#!/usr/bin/env python3
"""
Simple script to create a PNG launcher icon for Taskify.
This creates a basic version that can be used as a launcher icon.
"""
import os
from PIL import Image, ImageDraw, ImageFont

def create_taskify_icon():
    # Create a 1024x1024 image
    size = 1024
    image = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    
    # Background gradient circle (approximated with solid color)
    primary_color = (108, 99, 255)  # #6C63FF
    draw.ellipse([32, 32, size-32, size-32], fill=primary_color)
    
    # Task list container
    list_rect = [280, 240, 744, 800]
    draw.rounded_rectangle(list_rect, radius=40, fill=(255, 255, 255))
    
    # Task list lines
    line_color = (229, 231, 235)  # #E5E7EB
    draw.rounded_rectangle([360, 320, 640, 332], radius=6, fill=line_color)
    draw.rounded_rectangle([360, 380, 600, 392], radius=6, fill=line_color)
    draw.rounded_rectangle([360, 440, 680, 452], radius=6, fill=line_color)
    draw.rounded_rectangle([360, 560, 620, 572], radius=6, fill=line_color)
    draw.rounded_rectangle([360, 620, 560, 632], radius=6, fill=line_color)
    draw.rounded_rectangle([360, 680, 640, 692], radius=6, fill=line_color)
    
    # Checkboxes
    checkbox_color = (243, 244, 246)  # #F3F4F6
    checkbox_border = (209, 213, 219)  # #D1D5DB
    
    checkboxes = [
        [320, 310, 352, 342],
        [320, 370, 352, 402],
        [320, 430, 352, 462],
        [320, 550, 352, 582],
        [320, 610, 352, 642],
        [320, 670, 352, 702]
    ]
    
    for checkbox in checkboxes:
        draw.rounded_rectangle(checkbox, radius=8, fill=checkbox_color, outline=checkbox_border, width=2)
    
    # Completed checkbox
    completed_color = (78, 205, 196)  # #4ECDC4
    draw.rounded_rectangle([320, 490, 352, 522], radius=8, fill=completed_color)
    
    # Checkmark in completed checkbox (simple version)
    draw.line([328, 506, 334, 512], fill=(255, 255, 255), width=4)
    draw.line([334, 512, 344, 498], fill=(255, 255, 255), width=4)
    
    # Strikethrough line
    draw.line([360, 506, 640, 506], fill=(156, 163, 175), width=4)
    
    # Large checkmark overlay
    check_center = (700, 360)
    check_radius = 90
    draw.ellipse([check_center[0]-check_radius, check_center[1]-check_radius, 
                  check_center[0]+check_radius, check_center[1]+check_radius], 
                 fill=completed_color, outline=(255, 255, 255), width=12)
    
    # Large checkmark
    draw.line([660, 360, 690, 390], fill=(255, 255, 255), width=16)
    draw.line([690, 390, 740, 330], fill=(255, 255, 255), width=16)
    
    return image

def main():
    # Create the icon
    icon = create_taskify_icon()
    
    # Save as PNG
    icon.save('taskify_icon.png', 'PNG')
    print("Created taskify_icon.png")
    
    # Create smaller versions for different resolutions
    sizes = [512, 256, 128, 96, 72, 48, 36]
    for size in sizes:
        resized = icon.resize((size, size), Image.Resampling.LANCZOS)
        resized.save(f'taskify_icon_{size}.png', 'PNG')
        print(f"Created taskify_icon_{size}.png")

if __name__ == '__main__':
    main()