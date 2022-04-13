sll  $zero,$zero,0

goto:
addu $s2,$s1,$s0

subu $s3,$s2,$s0

ori  $s0,$s1,2

sll  $s1,$s3,2

lw   $s4,3($s0)

sw   $s4,4($s0)

beq  $s2,$s4,goto

j goto
