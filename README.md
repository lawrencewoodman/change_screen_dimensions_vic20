change_screen_dimensions_vic20
==============================

Two programs from the article [Changing the Screen Dimensions on the Commodore VIC-20](https://techtinkering.com/articles/changing-the-screen-dimensions-on-the-commodore-vic-20/).

The programs Basic source code is in _src/_ and the resulting _.prg_ files are in _bin/_

## choose_size

Basic program which allows you to choose the screen's character dimensions and then display to this screen format.  Supports: PAL, NTSC, unexpanded, +3K, +8K, +16K and +24K systems.

## my27x33

Simpler better documented Basic program to display a 27x33 character screen.  Supports: PAL, NTSC, unexpanded and +3K systems.

If you would like to try this code with smaller screen dimensions, which may may be more appropriate for NTSC systems, then you could use set the screen dimensions to 24x28 by changing the following lines.

``` basic
 130 sw=24:sh=28:rem screen width/height
 140 ox=-3:oy=-9:rem picture origin x/y offset
```

