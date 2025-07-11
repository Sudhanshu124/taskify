#!/usr/bin/env python3
"""
Create a simple PNG icon without external dependencies
"""
import struct
import zlib

def create_simple_png():
    # Create a simple 1024x1024 PNG with basic drawing
    width, height = 1024, 1024
    
    # Create RGBA data
    data = []
    for y in range(height):
        row = []
        for x in range(width):
            # Distance from center
            cx, cy = width // 2, height // 2
            dist = ((x - cx) ** 2 + (y - cy) ** 2) ** 0.5
            
            # Background circle
            if dist < 480:
                # Primary color #6C63FF
                r, g, b, a = 108, 99, 255, 255
            else:
                # Transparent
                r, g, b, a = 0, 0, 0, 0
            
            # Task list area
            if (280 <= x <= 744 and 240 <= y <= 800 and dist < 480):
                # White background
                r, g, b, a = 255, 255, 255, 255
            
            # Checkmark area
            if (650 <= x <= 750 and 310 <= y <= 410 and dist < 480):
                # Completed color #4ECDC4
                r, g, b, a = 78, 205, 196, 255
            
            row.extend([r, g, b, a])
        data.extend(row)
    
    # Create PNG file
    png_data = create_png_data(width, height, data)
    
    with open('taskify_icon.png', 'wb') as f:
        f.write(png_data)
    
    print("Created taskify_icon.png")

def create_png_data(width, height, rgba_data):
    # PNG signature
    png_signature = b'\x89PNG\r\n\x1a\n'
    
    # IHDR chunk
    ihdr_data = struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)
    ihdr_crc = zlib.crc32(b'IHDR' + ihdr_data) & 0xffffffff
    ihdr_chunk = struct.pack('>I', len(ihdr_data)) + b'IHDR' + ihdr_data + struct.pack('>I', ihdr_crc)
    
    # IDAT chunk
    raw_data = b''.join(b'\x00' + bytes(rgba_data[i:i+width*4]) for i in range(0, len(rgba_data), width*4))
    compressed_data = zlib.compress(raw_data)
    idat_crc = zlib.crc32(b'IDAT' + compressed_data) & 0xffffffff
    idat_chunk = struct.pack('>I', len(compressed_data)) + b'IDAT' + compressed_data + struct.pack('>I', idat_crc)
    
    # IEND chunk
    iend_crc = zlib.crc32(b'IEND') & 0xffffffff
    iend_chunk = struct.pack('>I', 0) + b'IEND' + struct.pack('>I', iend_crc)
    
    return png_signature + ihdr_chunk + idat_chunk + iend_chunk

if __name__ == '__main__':
    create_simple_png()