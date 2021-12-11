#####################################################################
#
# CSC258H5S Fall 2021 Assembly Final Project
# University of Toronto, St. George
#
# Student: Name, Student Number
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?

# - Milestone 5 
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. Display the number of lives remaining. (easy)
# 2. After final player death, display game over screen. Restart the game if "retry" option is chosen. (easy)
# 3. Display a death/respawn animation each time the player loses a frog. (easy)
# 4. Add a third row in each of the water and road sections. (easy)
# 5. Display the player's score at the top of the screen. (hard)
# 6. Add sound effects for movement, collisions, game end and reaching the goal area. (hard)
#
# Any additional information that the TA needs to know:
#	
#
#
#
#
# 	My game is so hard to win in three lives. 
#	I designed that as soon as the frog goes across the rive, it wins.
#	(It is easy to set to five goal region. You only need to detect the color five times and 
#	cover it with another color each time the frog arrives.)
#
#####################################################################


.data
displayAddress: .word 0x10008000
grass_color: .word 0x8E7CC3
frog_color: .word 0x00FF00
water_color: .word 0x3D85C6
road_color: .word 0x444444
wood_color: .word 0x783F04
car_color: .word 0xFF0000
goal_color: .word 0xCC0000
frog_location: .word 4028
score_message: .asciiz "\nYour current score is: "
live_message: .asciiz "    Your remaining live is: "
add_message: .asciiz "    Be careful!"
fail_message: .asciiz " \n \nYou failed. Press 'R' to retry " 
success_message: .asciiz "\nCongratulations! You survived£¡\n"
.text

addi $k0, $zero, 0 #score
addi $k1, $zero, 3     #lives 


all:
lw $t0, displayAddress # $t0 stores the base address for display
lw $t1, grass_color # $t1 stores the evil purple colour code for grass
lw $t2, water_color # $t2 stores the blue colour code for water
lw $t3, road_color # $t3 stores the black colour code for road
lw $t6, frog_color # $t3 stores the green colour code for frog
lw $t7, wood_color
lw $s7, goal_color

addi $s0, $t0, 4028 #s0 store the frog location. 4028 is the initial location
addi $s4, $t0, 0 #s1 store the first row of wood location
addi $s6, $t0, 128



main:

li, $v0, 32
li $a0, 160
syscall

jal draw_background
jal draw_car_1
jal draw_wood_1
jal draw_line
addi $s4, $s4, 4
subi $s6, $s6, 4
jal draw_frog
jal move_frog



syscall















#######################################################################################
#functions beneath

draw_right:
		jal draw_wood_one
		jal draw_wood_two
		jr $ra




draw_wood_one:	
		
		
		addi $t4, $s4, 256
		sw $t7, 0($t4)  # draw one wood beginning from $t0 location
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		sw $t7, 24($t4)
		addi $t4, $t4, 128
		sw $t7, 0($t4)
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		sw $t7, 24($t4)
		addi $t4, $t4, 128
		sw $t7, 0($t4)
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		sw $t7, 24($t4)
		jr $ra
		
draw_wood_two:	
		addi $t4, $s4, 32
		sw $t7, 0($t4)  # draw one wood beginning from $t0 location
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		sw $t7, 24($t4)
		sw $t7, 28($t4)
		addi $t4, $t4, 128
		sw $t7, 0($t4)
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		sw $t7, 24($t4)
		sw $t7, 28($t4)
		addi $t4, $t4, 128
		sw $t7, 0($t4)
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		sw $t7, 24($t4)
		sw $t7, 28($t4)
		jr $ra
		
draw_wood_three:	
		sw $t7, 0($t4)  # draw one wood beginning from $t0 location
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		addi $t4, $t4, 128
		sw $t7, 0($t4)
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		addi $t4, $t4, 128
		sw $t7, 0($t4)
		sw $t7, 4($t4)
		sw $t7, 8($t4)
		sw $t7, 12($t4)
		sw $t7, 16($t4)
		sw $t7, 20($t4)
		jr $ra
		
draw_car_one:   
		sw $t8, 0($t4)  # draw one car beginning from $t0 location
		sw $t8, 4($t4)
		sw $t8, 8($t4)
		addi $t4, $t4, 128
		sw $t8, 0($t4)  
		sw $t8, 4($t4)
		sw $t8, 8($t4)
		addi $t4, $t4, 128
		sw $t8, 0($t4)  
		sw $t8, 4($t4)
		sw $t8, 8($t4)
		subi $t4, $t4, 256	
		jr $ra	
		
draw_car_two:
		sw $t8, 0($t4)  # draw one car beginning from $t0 location
		sw $t8, 4($t4)
		sw $t8, 8($t4)
		sw $t8, 12($t4)
		addi $t4, $t4, 128
		sw $t8, 0($t4)  
		sw $t8, 4($t4)	
		sw $t8, 8($t4)
		sw $t8, 12($t4)
		addi $t4, $t4, 128
		sw $t8, 0($t4)  
		sw $t8, 4($t4)	
		sw $t8, 8($t4)
		sw $t8, 12($t4)
		subi $t4, $t4, 256
		jr $ra	

		
move_frog:	lw $s1, 0xffff0000
		#here can sleep
		beq $s1, 1, keyboard_input
		
		
		
		
		j exit

		keyboard_input:
		lw $s2, 0xffff0004
		beq $s2, 0x61, respond_to_A
		beq $s2, 0x77, respond_to_W
		beq $s2, 0x73, respond_to_S
		beq $s2, 0x64, respond_to_D
		beq $s2, 0x52, respond_to_R



respond_to_A:
	li $a0, 70  #sound to jump
    	li $a1, 4000 
   	li $a2, 120 
    	li $a3, 64 
    	li $v0, 31
    	syscall
subi $s0, $s0, 8 #move

addi $k0, $k0, 1 # show score
li $v0, 4
la $a0, score_message
syscall
li $v0, 1
move $a0, $k0
syscall


li $v0, 4
la $a0, live_message
syscall

li $v0, 1
move $a0, $k1
syscall

li $v0, 4
la $a0, add_message
syscall

j exit


respond_to_W:

	li $a0, 70  #sound to jump
    	li $a1, 4000 
   	li $a2, 120 
    	li $a3, 64 
    	li $v0, 31
    	syscall
subi $s0, $s0, 256 #move


li $v0, 4
la $a0, score_message
syscall
addi $k0, $k0, 1 # show score
li $v0, 1
move $a0, $k0
syscall

li $v0, 4
la $a0, live_message
syscall

li $v0, 1
move $a0, $k1
syscall

li $v0, 4
la $a0, add_message
syscall

j exit



respond_to_S:

	li $a0, 70  #sound to jump
    	li $a1, 4000 
   	li $a2, 120 
    	li $a3, 64 
    	li $v0, 31
    	syscall
addi $s0, $s0, 256 #move

li $v0, 4
la $a0, score_message
syscall
addi $k0, $k0, 1 # show score
li $v0, 1
move $a0, $k0
syscall


li $v0, 4
la $a0, live_message
syscall

li $v0, 1
move $a0, $k1
syscall

li $v0, 4
la $a0, add_message
syscall

j exit



respond_to_D:

	li $a0, 70  #sound to jump
    	li $a1, 4000 
   	li $a2, 120 
    	li $a3, 64 
    	li $v0, 31
    	syscall
addi $s0, $s0, 8 #move
addi $k0, $k0, 1 # show score
li $v0, 4
la $a0, score_message
syscall
li $v0, 1
move $a0, $k0
syscall


li $v0, 4
la $a0, live_message
syscall

li $v0, 1
move $a0, $k1
syscall

li $v0, 4
la $a0, add_message
syscall
j exit

respond_to_R:
		addi $k1, $zero, 3
		addi $k0, $zero, 0
		j all









draw_frog:	
		addi $t4, $s0, 0
		
		
		lw $t9, 0($t4)   
		beq $t9, $t2 lose     #change the color of lose condition here!!!!!!!!!
		beq $t9, $s7 success
		
	#	lw $t9, 0($t4)
	#	bne $t9, $s7 new_draw_frog
	#	j success
		

new_draw_frog:		
		sw $t6, 0($t4)
		subi $t4, $t4, 4
		sw $t6, 0($t4)
		subi $t4, $t4, 124
		sw $t6, 0($t4)
		subi $t4, $t4, 4		
		sw $t6, 0($t4)
		jr $ra




draw_background:	
		add $t4, $zero, $t0     # $ draw this pixel at this location. Display addres
		add $t5, $zero, $zero   # t5 = i
destination:  	

		beq $t5, 260, water_region
	      	sw $s7, 0($t4)     #  draw purple color to destination
	      	add $t4, $t5, $t0       
		addi $t5, $t5, 4
		j destination

water_region:	

		beq $t5, 1796, middle_region
		sw $t2, 0($t4) #draw water color
		add $t4, $t5, $t0
		addi $t5, $t5, 4
		j water_region

middle_region: 	beq $t5, 2180, road_region
		sw $t1, 0($t4) # draw purple color
		add $t4, $t5, $t0
		addi $t5, $t5, 4
		j middle_region
		
road_region: 	

		beq $t5, 3844, start_region
		sw $t3, 0($t4)  #draw black road
		add $t4, $t5, $t0       
		addi $t5, $t5, 4
		j road_region

start_region:   beq $t5, 4100, return
		sw $t1, 0($t4)	# draw start region
		add $t4, $t5, $t0       
		addi $t5, $t5, 4
		j start_region
		
return:		
		jr $ra





draw_car_1:
		add $t4, $s4, 2176
		sub $t5, $t4, $t0
		bne $t5, 2304, draw1
		subi $t4, $t4, 128
		subi $s4, $s4, 128
		
		
draw1:		sw $t2, 0($t4)
		sw $t2, 128($t4)
		sw $t2, 256($t4)
		sw $t2, 384($t4)
		sw $t2, 60($t4)
		sw $t2, 188($t4)
		sw $t2, 336($t4)
		sw $t2, 464($t4)
		sw $t2, 168($t4)
		sw $t2, 296($t4)
		
		sw $t2, 700($t4)
		sw $t2, 828($t4)
		sw $t2, 956($t4)
		sw $t2, 760($t4)
		sw $t2, 888($t4)
		
		sw $t2, 996($t4)
		sw $t2, 1124($t4)
		sw $t2, 956($t4)
		sw $t2, 1252($t4)
		sw $t2, 1184($t4)
		sw $t2, 1312($t4)
		sw $t2, 1440($t4)
		sw $t2, 1480($t4)

jr $ra











fail:		
	li $a0, 66  #fail sound
    	li $a1, 10000 
   	li $a2, 116 
    	li $a3, 140
    	li $v0, 31
    	syscall
		sw $t6, 1200($t0)
		sw $t6, 1204($t0)
		sw $t6, 1208($t0)
		sw $t6, 1212($t0)
		sw $t6, 1216($t0)
		sw $t6, 1220($t0)
		sw $t6, 1224($t0)

		sw $t6, 1328($t0)
		sw $t6, 1456($t0)
		sw $t6, 1584($t0)
		sw $t6, 1712($t0)
		sw $t6, 1840($t0)
		sw $t6, 1968($t0)
		sw $t6, 2096($t0)
		sw $t6, 2224($t0)
		sw $t6, 2352($t0)
		sw $t6, 2480($t0)
		sw $t6, 2608($t0)

		sw $t6, 1968($t0)
		sw $t6, 1972($t0)
		sw $t6, 1976($t0)
		sw $t6, 1980($t0)
		sw $t6, 1984($t0)
		sw $t6, 1988($t0)
		
		li, $v0, 32
		li $a0, 3000
		syscall
		
		
		li $v0, 4
		la $a0, fail_message
		syscall
		


		j move_frog
		syscall



draw_line:	addi $t4, $t0, 1792
		sw $t1, 0($t4)
		sw $t1, 4($t4)
		sw $t1, 8($t4)
		sw $t1, 12($t4)
		sw $t1, 16($t4)
		sw $t1, 20($t4)
		sw $t1, 24($t4)
		sw $t1, 28($t4)
		sw $t1, 32($t4)
		sw $t1, 36($t4)
		sw $t1, 40($t4)
		sw $t1, 44($t4)
		sw $t1, 48($t4)
		sw $t1, 52($t4)
		sw $t1, 56($t4)
		sw $t1, 60($t4)
		sw $t1, 64($t4)
		sw $t1, 68($t4)
		sw $t1, 72($t4)
		sw $t1, 76($t4)
		sw $t1, 80($t4)
		sw $t1, 84($t4)
		sw $t1, 88($t4)
		sw $t1, 92($t4)
		sw $t1, 96($t4)
		sw $t1, 100($t4)
		sw $t1, 104($t4)
		sw $t1, 108($t4)
		sw $t1, 112($t4)
		sw $t1, 116($t4)
		sw $t1, 120($t4)
		sw $t1, 124($t4)
		
		jr $ra



draw_wood_1:
		add $t4, $s6, 256
		sub $t5, $t4, $t0
		bne $t5, 256, draw2
		subi $t4, $t4, 128
		addi $s6, $s6, 128
draw2:
		sw $t7, 0($t4)
		sw $t7, 128($t4)
		sw $t7, 256($t4)
		sw $t7, 384($t4)
		sw $t7, 4($t4)
		sw $t7, 132($t4)
		sw $t7, 260($t4)
		sw $t7, 388($t4)
		sw $t7, 8($t4)
		sw $t7, 136($t4)
		sw $t7, 264($t4)
		sw $t7, 392($t4)
		sw $t7, 12($t4)
		sw $t7, 140($t4)
		sw $t7, 268($t4)
		sw $t7, 396($t4)
		sw $t7, 16($t4)
		sw $t7, 144($t4)
		sw $t7, 272($t4)
		sw $t7, 400($t4)
		
		
		
		sw $t7, 40($t4)
		sw $t7, 168($t4)
		sw $t7, 296($t4)
		sw $t7, 424($t4)
		sw $t7, 44($t4)
		sw $t7, 172($t4)
		sw $t7, 300($t4)
		sw $t7, 428($t4)
		sw $t7, 48($t4)
		sw $t7, 176($t4)
		sw $t7, 304($t4)
		sw $t7, 432($t4)
		sw $t7, 52($t4)
		sw $t7, 180($t4)
		sw $t7, 308($t4)
		sw $t7, 436($t4)
		sw $t7, 56($t4)
		sw $t7, 184($t4)
		sw $t7, 312($t4)
		sw $t7, 440($t4)
	
		sw $t7, 600($t4)
		sw $t7, 728($t4)
		sw $t7, 856($t4)
		sw $t7, 984($t4)
		sw $t7, 604($t4)
		sw $t7, 732($t4)
		sw $t7, 860($t4)
		sw $t7, 988($t4)
		sw $t7, 608($t4)
		sw $t7, 736($t4)
		sw $t7, 864($t4)
		sw $t7, 992($t4)
		sw $t7, 612($t4)
		sw $t7, 740($t4)
		sw $t7, 868($t4)
		sw $t7, 996($t4)
		sw $t7, 516($t4)
		sw $t7, 644($t4)
		sw $t7, 772($t4)
		sw $t7, 900($t4)
		
		sw $t7, 500($t4)
		sw $t7, 628($t4)
		sw $t7, 756($t4)
		sw $t7, 884($t4)
		sw $t7, 504($t4)
		sw $t7, 632($t4)
		sw $t7, 760($t4)
		sw $t7, 888($t4)
		sw $t7, 508($t4)
		sw $t7, 636($t4)
		sw $t7, 764($t4)
		sw $t7, 892($t4)
		sw $t7, 512($t4)
		sw $t7, 640($t4)
		sw $t7, 768($t4)
		sw $t7, 896($t4)
		sw $t7, 516($t4)
		sw $t7, 644($t4)
		sw $t7, 772($t4)
		sw $t7, 900($t4)
	
		sw $t7, 1040($t4)
		sw $t7, 1168($t4)
		sw $t7, 1296($t4)
		sw $t7, 1424($t4)
		sw $t7, 1044($t4)
		sw $t7, 1172($t4)
		sw $t7, 1300($t4)
		sw $t7, 1428($t4)
		sw $t7, 1048($t4)
		sw $t7, 1176($t4)
		sw $t7, 1304($t4)
		sw $t7, 1432($t4)
		sw $t7, 1052($t4)
		sw $t7, 1180($t4)
		sw $t7, 1308($t4)
		sw $t7, 1436($t4)
		sw $t7, 1056($t4)
		sw $t7, 1184($t4)
		sw $t7, 1312($t4)
		sw $t7, 1440($t4)
		
			
		sw $t7, 1100($t4)
		sw $t7, 1228($t4)
		sw $t7, 1356($t4)
		sw $t7, 1484($t4)
		sw $t7, 1104($t4)
		sw $t7, 1232($t4)
		sw $t7, 1360($t4)
		sw $t7, 1488($t4)
		sw $t7, 1108($t4)
		sw $t7, 1236($t4)
		sw $t7, 1364($t4)
		sw $t7, 1492($t4)
		sw $t7, 1112($t4)
		sw $t7, 1240($t4)
		sw $t7, 1368($t4)
		sw $t7, 1496($t4)
		sw $t7, 1116($t4)
		sw $t7, 1244($t4)
		sw $t7, 1372($t4)
		sw $t7, 1500($t4)	
	
		jr $ra






success:
	li $a0, 70 #sound for suceess
    	li $a1, 10000 
   	li $a2, 104 
    	li $a3, 70
    	li $v0, 31
    	syscall
sw $t6, 1176($t0)
sw $t6, 1180($t0)
sw $t6, 1184($t0)
sw $t6, 1188($t0)
sw $t6, 1192($t0)
sw $t6, 1196($t0)
sw $t6, 1200($t0)
sw $t6, 1204($t0)
sw $t6, 1208($t0)
sw $t6, 1212($t0)
sw $t6, 1216($t0)
sw $t6, 1220($t0)
sw $t6, 1224($t0)

sw $t6, 1328($t0)
sw $t6, 1456($t0)
sw $t6, 1584($t0)
sw $t6, 1712($t0)
sw $t6, 1840($t0)
sw $t6, 1968($t0)
sw $t6, 2096($t0)
sw $t6, 2224($t0)
sw $t6, 2352($t0)
sw $t6, 2480($t0)
sw $t6, 2608($t0)

li $v0, 4
la $a0, success_message
syscall

li, $v0, 32
li $a0, 6000
syscall
j respond_to_R



				
lose:
	li $a0, 70  #sound fro lose
    	li $a1, 10000 
   	li $a2, 108 
    	li $a3, 100
    	li $v0, 31
    	syscall
subi $k1, $k1, 1
beq $k1, $zero, fail

sw $t6, 1328($t0)
sw $t6, 1456($t0)
sw $t6, 1584($t0)
sw $t6, 1712($t0)
sw $t6, 1840($t0)
sw $t6, 1968($t0)
sw $t6, 2096($t0)
sw $t6, 2224($t0)
sw $t6, 2352($t0)
sw $t6, 2480($t0)
sw $t6, 2608($t0)

sw $t6, 2612($t0)
sw $t6, 2616($t0)
sw $t6, 2620($t0)
sw $t6, 2624($t0)
sw $t6, 2628($t0)
sw $t6, 2632($t0)
sw $t6, 2636($t0)
sw $t6, 2640($t0)

li, $v0, 32
li $a0, 3000
syscall

j all
syscall
		
						
exit: 		
		syscall
		j main
