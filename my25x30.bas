   10 rem lower end of basic to $1800
   20 poke 55,0:poke 56,24
   30 poke 51,0:poke 52,24

  100 rem save screen values
  110 da=peek(36867)
  120 db=peek(36866)
  130 dc=peek(36869)
  140 dd=peek(36864)
  150 de=peek(36865)

  200 print "{clr}screen width?"
  210 input sw
  220 print "screen height?"
  230 input sh

  300 gosub 1000
  310 gosub 3000

  400 rem print hello worlds
  410 pc=0
  420 for py=1 to sh-2
  430 px=sw-13:st$="Hello World!":gosub 5000
  440 pc=pc+1
  450 if pc=1 then pc=2
  460 if pc>7 then pc=2
  470 next py

  500 rem wait for a key
  520 pc=0:px=(sw-13)/2:py=sh-1:st$="Press any key":gosub 5000
  540 input a$

  600 gosub 6000
  610 end

 1000 rem expand scr
 1010 poke 36867,(peek(36867)and 128)or (sh*2)
 1020 poke 36866,sw
 1030 poke 36869,224
 1040 if sw>=23 then poke 36864,peek(36864)-(sw-23)*2: rem move horizontal origin
 1050 if sh>=22 then poke 36865,peek(36865)-(sh-22)*2: rem move vertical origin
 1060 return

 2000 rem print char
 2001 rem args: px,py,ps,pc
 2010 poke 6144+px+(py*sw),ps
 2020 poke 37888+px+(py*sw),pc
 2030 return

 3000 rem clear screen
 3010 for i=0 to (sw*sh)-1
 3020 poke 6144+i,32:poke 37888+i,6
 3030 next i
 3040 return

 4000 rem ascii to screen code - p111 mapping the vic
 4001 rem args: ac - ret: sc
 4010 sc=ac:if ac>127 and ac<159 then sc=0: goto 4100
 4020 if ac<64 then 4100
 4030 sc=ac-32
 4040 if ac<96 then sc=sc-32:goto 4100
 4050 if ac<128 then 4100
 4060 sc=sc-32
 4070 if ac>191 then sc=sc-64
 4080 if ac=255 then sc=30
 4100 return

 5000 rem print string
 5001 rem args: st$, px, py, pc
 5010 for i=1 to len(st$)
 5020 ac=asc(mid$(st$,i,1)):gosub 4000
 5030 ps=sc:gosub 2000
 5040 px=px+1
 5050 next i
 5060 return

 6000 rem restore screen and quit
 6010 poke 36867,da
 6020 poke 36866,db
 6030 poke 36869,dc
 6040 poke 36864,dd
 6050 poke 36865,de
