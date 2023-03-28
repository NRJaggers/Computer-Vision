impath = '../Images/easy1.jpg';
im = imread(impath);
hsvIm = rgb2hsv(im);
% HSV values for the colors of a resistor:
blackHSV = [0 0 0];
brownHSV = [0.05 0.4 0];
redHSV = [0 1 1];
orangeHSV = [0.0690 0.8502 0.9385];
yellowHSV = [0.17 1 1];
greenHSV = [0.2604 0.7459 0.6522];
blueHSV = [0.5037 0.6880 0.6035];
violetHSV = [0.83 0.5 1];
greyHSV = [0 0 0.5];
whiteHSV = [0 0 1];
goldHSV = [0.0898 0.5608 0.8463];
silverHSV = [0 0.75 0.75];
% Index values
blackIdx = 1;
brownIdx = 2;
redIdx = 3;
orangeIdx = 4;
yellowIdx = 5;
greenIdx = 6;
blueIdx = 7;
violetIdx = 8;
greyIdx = 9;
whiteIdx = 10;
goldIdx = 11;
silverIdx = 12;
colorHSV = [blackHSV; brownHSV; redHSV; orangeHSV; yellowHSV; greenHSV; blueHSV; violetHSV; greyHSV; whiteHSV; goldHSV; silverHSV];
% colorHSV = [blackHSV; brownHSV; redHSV; whiteHSV];
hsvToIdx([0.2604 0.5037 0.0690 0.0898;0.7459 0.6880 0.8502 0.5608;0.6522 0.6035 0.9385 0.8463], colorHSV);
% hsvToIdx([0.2604;0.7459;0.6522], colorHSV);
subplot(221), imshow(im), title("Regular");
subplot(222), imshow(hsvIm), title("HSV");
function inRange = inrange(x, value, error)
   % Returns true if x is in range of value by error or false otherwise
   inRange = (x >= value - (value * error)) & (x <= value + (value * error));
end
function idxRes = hsvToIdx(featVec, color)
   errorRange = 0.1;
   numBands = size(featVec, 2);
   numColors = size(color, 1);
   for i = 1:numBands
       for j = 1:numColors
           thisColor = color(j,:);
           hueInRange = inrange(featVec(1, i), thisColor(1), errorRange);
           satInRange = inrange(featVec(2, i), thisColor(2), errorRange);
           % valInRange = inrange(featVec(i, 3), thisColor(3), errorRange);
           %disp(featVec(1, i));
           %disp(featVec(2,i));
           % disp(thisColor(1))
           if (hueInRange && satInRange)
               disp("Band: " + i)
               disp("Color index: " + j)
               idxRes = [i,j];
               break;
           end
       end
   end
end
