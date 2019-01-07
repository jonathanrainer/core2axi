# Get the directory where this script resides
set thisDir [file dirname [info script]]
set workDir [file join $thisDir .. work]

# Set up folders to be refered to later
set rtlRoot [file join $thisDir .. rtl]

# Set up list of RTL files
set rtlFiles {
    core2axi.sv
    core2axi_wrapper.v
}


set rtlFilesFull {}

foreach f $rtlFiles {
    lappend rtlFilesFull [file join $rtlRoot $f]
}

# Create project 
create_project -part xc7vx485tffg1761-2  -force core2axi [file join $workDir]
add_files -norecurse $rtlFilesFull

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
