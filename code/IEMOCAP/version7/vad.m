function [x1,x2] = vad( recording ,setting )

% Normalization to [-1,1]
recording = double( recording );
recording = recording / max( abs( recording ) );

% Constant
FrameLen = setting.frameLength;  %% 1280/16000=0.08s
FrameInc = FrameLen / 2;

amp1 = 10;
amp2 = 2;
zcr1 = 10;
zcr2 = 5;

maxsilence = setting.maxSilence;  % 10*0.08 = 0.8s 
minlen  = setting.minLength;    % 25*0.08ms = 2s
status  = 0;
count   = 0;
silence = 0;

% Calculate zero-cross rate  
tmp1  = enframe( recording( 1:end-1 ), FrameLen, FrameInc );
tmp2  = enframe( recording( 2:end)  , FrameLen, FrameInc );
signs = ( tmp1.*tmp2 ) < 0;
diffs = ( tmp1 -tmp2 ) > 0.02;
zcr   = sum( signs.*diffs, 2 );

% Calculate short-time energy 
amp = sum(abs(enframe(filter([1 -0.9375], 1, recording ), FrameLen, FrameInc)), 2);

% Adjust energy threshold
amp1 = min( amp1, max( amp ) / 4 );
amp2 = min( amp2, max( amp ) / 8 );

% Start voice activity detection
x1 = 0; 
x2 = 0;
for n=1 : length( zcr )
   goto = 0;
   switch status
   case {0,1}                   % 0 = ����, 1 = ���ܿ�ʼ
      if amp(n) > amp1          % ȷ�Ž���������
         x1 = max(n-count-1,1);
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... % ���ܴ���������
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                       % ����״̬
         status  = 0;
         count   = 0;
      end
   case 2,                       % 2 = ������
      if amp(n) > amp2 | ...     % ������������
         zcr(n) > zcr2
         count = count + 1;
      else                       % ����������
         silence = silence+1;
         if silence < maxsilence % ����������������δ����
            count  = count + 1;
         elseif count < minlen   % ��������̫�̣���Ϊ������
            status  = 0;
            silence = 0;
            count   = 0;
         else                    % ��������
            status  = 3;
         end
      end
   case 3,
      break;
   end
end   

count = count-silence/2;
x2 = x1 + count +1;

x1 = x1 * FrameInc;
x2 = x2 * FrameInc;
