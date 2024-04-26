; 88x31 button, this was mostly taken from favicon.asm
; I feel like the novelty of an image created with an assembler is gone to me at
; this point, but I refuse to use anything other than MS paint and I also refuse
; to use Windows. It's a real problem.

; NOTE TO SELF: There are some hard-coded numbers in library.c, change those if
; you're changing these

bmp_header:
  db "BM"                      ; Magic number
  dd bmp_end - bmp_header      ; File size
  dw 0                         ; Reserved
  dw 0                         ; Reserved
  dd img_data - bmp_header     ; Initial data location

dib_header:
  dd color_table - dib_header  ; Size of DIB header
  dd 88                        ; Width
  dd 31                        ; Height
  dw 1                         ; No. of color planes
  dw 4                         ; Bits per pixel
  dd 0                         ; Compression method (none)
  dd bmp_end - img_data        ; Image size
  dd 1337                      ; Horizontal resolution (px/meter)
  dd 1337                      ; Vertical resolution (px/meter)
  dd 4                         ; No. of colors
  dd 0                         ; Important colors

color_table:
  db 0x31, 0x41, 0x59, 0x00   ; "white"
  db 0x99, 0x99, 0x99, 0x00   ; "grey"
  db 0x00, 0x00, 0xff, 0x00   ; "impact (red)"
  db 0x00, 0x00, 0x00, 0x00   ; "black"

img_data:
  db 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00110011, 0b00110000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00110011, 0b00110000, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00110011, 0b00000000, 0b00110011, 0b00110011, 0b00000000, 0b00110011, 0b00110011, 0b00110000, 0b00000000, 0b00110000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00110011, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00110011, 0b00000000, 0b00110000, 0b00000000, 0b00110000, 0b00110000, 0b00000000, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000011, 0b00000011, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00110011, 0b00000000, 0b00110000, 0b00000000, 0b00110000, 0b00110011, 0b00110011, 0b00110000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00110000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00110000, 0b00000000, 0b00110000, 0b00110000, 0b00000000, 0b00000000, 0b00110000, 0b00000000, 0b00110000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00110011, 0b00110000, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00110011, 0b00110000, 0b00000011, 0b00000000, 0b00000011, 0b00000000, 0b00110011, 0b00110000, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00000000, 0b00000000, 0b00110011, 0b00110011, 0b00000000, 0b00110011, 0b00110011, 0b00110000, 0b00110000, 0b00000000, 0b00110000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00100010, 0b00100010, 0b00100000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00100010, 0b00100010, 0b00100000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100000, 0b00000010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00100010, 0b00100000, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100010, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100000, 0b00000000, 0b00000010, 0b00100010, 0b00100000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00000000, 0b00000010, 0b00100010, 0b00100010, 0b00100000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000010, 0b00100000, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100010, 0b00100010, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00100010, 0b00100000, 0b00000010, 0b00100000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100000, 0b00000010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000010, 0b00100010, 0b00100010, 0b00100010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00100010, 0b00100010, 0b00100000, 0b00000000, 0b00100010, 0b00100010, 0b00100000, 0b00000010, 0b00100000, 0b00000000, 0b00100010, 0b00000000, 0b00100010, 0b00100010, 0b00100010, 0b00000000, 0b00100010, 0b00100010, 0b00100000, 0b00000000, 0b00100010, 0b00100010, 0b00100000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00110000, 0b00110000, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00110011, 0b00110000, 0b00000000, 0b00110011, 0b00110000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000011, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000011, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000011, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00110000, 0b00110011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00110011, 0b00110011, 0b00000011, 0b00000000, 0b00000000, 0b00000000, 0b00110011, 0b00110000, 0b00000000, 0b00110011, 0b00110000, 0b00000011, 0b00000000, 0b00000011, 0b00000011, 0b00110011, 0b00110011, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001
  db 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001

; Here's what I was working with in Vim, I had to manually add these bits in
; while designing it upside down. This is a grueling process. I'd use some vim
; magic to convert this to a usable format.
;  db 0b01010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101
;  db 0b01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100000101010101000001010000000101000001010101010100010100000001010000010101010100000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100010101010101010001010000010101000101010101010100010100000001010001010101010101000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100010100000001010001010001010100000101000000000000010100000001010001010000000101000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100010100000000000001010101010000000101000000000000010100000001010000000000000101000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100010100000000000001010101000000000101000000000000010100000001010000000000000101000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010101010101000101010101010100010100000000000001010100000000000101010101010100010101010101000000000101010100000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010101010101000101010101010100010100000000000001010100000000000101010101010100010101010100000001010101010100000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100010100000000000001010101000000000101000000000000010100000101000001010000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100010100000000000001010101010000000101000000000000010100000001010001010000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101000000010100010100000001010001010001010100000101000000000000010100000001010001010000000101000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000101010101010100010101010101010001010000010101000101010101010100010101010101010001010101010101000000000000000000000000000000001
;  db 0b01000000000000000000000000000000001010000000101000001010101010000000101010101000001010000000101000001010101010100000101010101000000010101010100000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000011000000110011000000110000001100000011111111110000111111000011000000110000111111000011111111110011111100001111111100001111111111000000110000000000000000000001
;  db 0b01000000000000000011000011110011000000110000001100000011000000000011000000110011000000110011000000110011000000000011111100001100000011001100000000000011001100000000000000000001
;  db 0b01000000000000000011001100110011111111110000001100000011111111110011000000000011111111110011000000110011111111110011111100001100000011001111111111000011001100000000000000000001
;  db 0b01000000000000000011110000110011000000110000001100000011000000000011000000110011000000110011000000110011000000000000000000001100000011001100000000001100000011000000000000000001
;  db 0b01000000000000000011000000110000111111000011111111110011111111110000111111000011000000110000111111000011111111110000000000001111111100001111111111001100000011000000000000000001
;  db 0b01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000000011001100001111111111001111111111000011111100000011111100001100000011001111111111000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000001100110011001100000000001100000000001100000011001100000011001100000011001100000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000001100110011001100000000001100000000001100000000001100000011001100000011001100000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000001100000011001111111111001100000000001100000000001100000011001100000011001111111111000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000001100000011001100000000001100000000001100000000001100000011001100110011001100000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000001100000011001100000000001100000000001100000011001100000011001111001111001100000000000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000001100000011001111111111001100000000000011111100000011111100001100000011001111111111000000000000000000000000000000000000000000000001
;  db 0b01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
;  db 0b01010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101

; Early draft of the natechoe.dev 88x31 button
;  db 0b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000001111111100001000000100001111111100001111111100000000000000000000000000000000000001, 0
;  db 0b1000001000000000001000000100001000000100001000000000000000000000000000000000000000000001, 0
;  db 0b1000000100000000000100000010000100000010000100000000000000000000000000000000000000000001, 0
;  db 0b1000000100000000000100000010000100000010000100000000000000000000000000000000000000000001, 0
;  db 0b1000000010000000000010000001000010000001000010000000000000000000000000000000000000000001, 0
;  db 0b1000000010000000000010000001000010000001000010000000000000000000000000000000000000000001, 0
;  db 0b1000000001000000000001111111100001000000100001111111100000000000000000000000000000000001, 0
;  db 0b1000000001000000000001000000100001000000100001000000000000000000000000000000000000000001, 0
;  db 0b1000000000100000000000100000010000100000010000100000000000000000000000000000000000000001, 0
;  db 0b1000000000100000000000100000010000100000010000100000000000000000000000000000000000000001, 0
;  db 0b1000000000010000000000010000001000010000001000010000000000000000000000000000000000000001, 0
;  db 0b1000000000011111111000010000001000011111111000011111111000000000000000000000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000000000000000000000100000010000100000010000000010000000111111110000000000000000000001, 0
;  db 0b1000000000000000000000100000010000100000010000000010000000100000000000000000000000000001, 0
;  db 0b1000000000000000000000010000011000010000001000000001000000010000000000000000000000000001, 0
;  db 0b1000000000000000000000010000011000010000001000000001000000010000000000000000000000000001, 0
;  db 0b1000000000000000000000001000100100001000000100000000100000001000000000000000000000000001, 0
;  db 0b1000000000000000000000001000100100001000000100000000100000001000000000000000000000000001, 0
;  db 0b1000000000000000000000000100100010000111111110000000010000000111111110000000000000000001, 0
;  db 0b1000000000000000000000000100100010000100000010000000010000000100000000000000000000000001, 0
;  db 0b1000000000000000000000000011000001000010000001000000001000000010000000000000000000000001, 0
;  db 0b1000000000000000000000000011000001000010000001000000001000000010000000000000000000000001, 0
;  db 0b1000000000000000000000000001000000100001000000100000000100000001000000000000000000000001, 0
;  db 0b1000000000000000000000000001000000100001111111100001111111100001111111100000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, 0

bmp_end:
