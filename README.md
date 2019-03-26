# STM 32 F3 discovery
The main idea for this project was to write C code with Keil MDK-ARM-Basic IDE to collect data from an Inertial Measurement Unit (Magnetometer, Accelerometer and Giroscopes) integrated on STM32 Discovery, work with the I/O to signal the changes of orientation by LEDs and later pass the data to a Klaman Filter implemented in Matlab to work on it with direct-cosine-matrix/quaternions and visualise it.

The board is an ARM STM32F4 equipped with:
* 3D gyroscopes
* accelerometer
* magnetometer
* led circle
* pushbutton
* USB OTG/device on-board USB debugger

Build system based on Keil uVision and gcc/makefiles.

Projects/libraries

imu/ahrs fully fused algs with quaternion output and set of conversion functions into yaw/pitch/roll, euler etc.
complete template project for gcc/makefile
File contents
lib - set of libraries for overall support of the board

board - stm32f3discovery board specific files and utilities - serial port init - leds control - button control
imulib - library of imu related functions - Madgwick filter fusion algs (adapted/optimized) - on-board IMU devices read/initialize in correct aerospace order (optimized) - set of IMU/AHRS helper functions
CMSIS - ARM CORTEX M3 support definitions
STM32F30x_StdPeriph_Driver - CPU support package for STM32F30x
STM32_USB-FS-Device_Driver - CPU support package for USB endpoint
proj - set of projects based on this board

imutest - imu devices tests includes
Madgwick fusion filter algs
corrections/cal algs
imu conversions library
test/demo with serial output
extra - utilities for programming and starting gdb/ocd, linker scripts

Note
This works contains parts of ARM's CSIMS and STMicro support libraries and other related works by multiple authors.
