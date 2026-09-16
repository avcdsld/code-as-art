$ sudo bash grass.sh

_(){ cat /dev/sda|hexdump -v -e '/1 "%u\n"'|awk '{split(
"0,2,4,5,7,9,11,12",a,",");for(i=0;i<1;i+=0.000175)printf(
"%08X\n",128+sin(250*exp((a[$i%8]/12)*log(2))*i)))};}

    :    ()    {    :    <:>:
blades |spaced | like | notes| expand |
  to a |patch|of <:>:|grass |
inside| the  |man s|| head at | <:>:
   a<:>:festival| and| he  |becomes |
  a | true  |fuser |of<:>:| sounds|
from | the | sheeps | fold| and |
   the|cat  |mewing | to |find  |
   its |prey| with | the| more |
subtle | |music | of | the | plants|
that <:>:| begins| to |echo | over |
scores|| of | fields| and | now |
the  | grass| is<:>:like| hash| :  |
to  | the | touch | : |before|its|
cut  |    |     :     |
:||:||:||:||:||:||:||:||:||:||:||:;}}

_|tee >(xxd -r -p|aplay -c 2 -f S32_LE -r 16000)|\
awk '{for(i=0;i<($1/5);i++)printf" ";printf"|";}';
