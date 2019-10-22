   10 print "{clr}"
   20 if peek(36869)=192 then goto 200: rem if ram >= 8kb

  100 print "config: ram < 8kb":print
  110 poke 55,0:poke 56,24:rem lower end of basic to $1800
  120 poke 51,0:poke 52,24
  130 sm=6144:rem screen map location
  140 goto 300

  200 print "config: ram >= 8kb"
  210 print "membot:";(peek(43)+peek(44)*256):print
  220 sm=4096
  230 if peek(43)<>1 and peek(44)<>18 then 300
  240 print:print "move basic y/n";:input y$
  250 if y$="n" then 300:if y$<>"y" then 240
  260 poke 783,0:poke 781,133:poke 782,19:sys 65436
  270 print:print "reload program":print "after reset":print:print "*** press any key ***"
  280 input a$:sys 58232

  300 da=peek(36867):db=peek(36866)
  310 dc=peek(36869):dd=peek(36864):de=peek(36865)

  400 print "screen width";: input sw
  410 print "screen height";: input sh
  420 print "x tv offset";: input ox
  430 print "y tv offset";: input oy
  440 if sm=4096 and peek(43)+peek(44)*256-sm > sw*sh then 500
  450 goto 500
  460 print:print "error:"
  470 print "{red} screen map too small"
  480 print " move bottom of basic{blue}"
  490 end

  500 gosub 1000
  510 gosub 3000

  600 pc=0
  610 for py=1 to sh-2
  620 px=sw-13:st$="Hello World!":gosub 5000
  630 pc=pc+1
  640 if pc=1 then pc=2
  650 if pc>7 then pc=2
  660 next py

  700 pc=0:px=(sw-13)/2:py=sh-1:st$="Press any key":gosub 5000
  710 get a$:if a$="" then 700

  800 gosub 6000:end

 1000 poke 36867,(peek(36867)and 128)or (sh*2)
 1010 poke 36866,sw
 1020 if peek(36869)=240 then poke 36869,224
 1030 poke 36864,peek(36864)+ox
 1040 poke 36865,peek(36865)+oy
 1050 return

 2000 rem print char - args: px,py,ps,pc
 2010 poke sm+px+(py*sw),ps
 2020 poke 37888+px+(py*sw),pc
 2030 return

 3000 rem clear screen
 3010 for i=0 to (sw*sh)-1
 3020 poke sm+i,32:poke 37888+i,6
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

 5000 rem print string - args: st$, px, py, pc
 5010 for i=1 to len(st$)
 5020 ac=asc(mid$(st$,i,1)):gosub 4000
 5030 ps=sc:gosub 2000
 5040 px=px+1
 5050 next i
 5060 return

 6000 poke 36867,da:poke 36866,db
 6010 poke 36869,dc:poke 36864,dd:poke 36865,de
 6020 if sm=4096 then print "{clr}"
 6030 return
