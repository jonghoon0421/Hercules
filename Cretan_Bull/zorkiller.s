.name "ZorKiller"
.comment "TaklamakanKiller created me..."

fork	%:dest

init:	sti r1, %:dest, %1
		sti r1, %:barr, %1
		and r1, %0, r1

init2:	ld %0, r2

barr:	live %1
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, -200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		st r2, 200
		zjmp %:barr

dest:	live %1
		zjmp %:dest
