   10 rem demonstrate a 27x33 screen
   20 rem lawrence woodman, nov 2019
   30 print "{clr}"

  100 rem lower top of basic to $1c00
  110 poke 55,0:poke 56,28:poke 51,0:poke 52,28:clr
  120 sm=7168:cm=37888:rem screen map: $1c00 colour map: $9400
  130 sw=27:sh=33:rem screen width/height
  140 ox=-5:oy=-19:rem picture origin x/y offset

  200 rem record initial screen settings
  210 da=peek(36866):db=peek(36867):dc=peek(36869)
  220 dd=peek(36864):de=peek(36865)

  300 rem set up screen
  310 poke 36869,240:rem set screen map: $1c00
  320 poke 36866,sw:rem width, colour map: $9400
  330 poke 36867,(peek(36867)and 128)or (sh*2):rem height
  340 poke 36864,peek(36864)+ox:rem picture origin x offset
  350 poke 36865,peek(36865)+oy:rem picture origin y offset

  400 rem clear screen
  410 for i=0 to (sw*sh)-1
  420 poke sm+i,32:poke cm+i,6
  430 next i

  500 rem print hello worlds
  510 pc=0
  520 for py=1 to sh-2
  530 px=sw-13:st$="Hello World!":gosub 5000
  540 pc=pc+1:if pc=1 then pc=2
  550 if pc>7 then pc=2
  560 next py

  600 rem wait for a key press
  610 pc=0:px=(sw-13)/2:py=sh-1:st$="Press any key":gosub 5000
  620 get a$:if a$="" then 620

  700 rem restore screen settings
  710 poke 36866,da:poke 36867,db:poke 36869,dc
  720 poke 36864,dd:poke 36865,de
  730 print "{clr}"
  740 end

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

 5000 rem print string - args: st$, px, py, pc
 5010 for i=1 to len(st$)
 5020 ac=asc(mid$(st$,i,1)):gosub 4000
 5030 ps=sc
 5040 gosub 6000
 5050 px=px+1
 5060 next i
 5070 return

 6000 rem print char - args: px,py,ps,pc
 6010 poke sm+px+(py*sw),ps:poke cm+px+(py*sw),pc
 6020 return
