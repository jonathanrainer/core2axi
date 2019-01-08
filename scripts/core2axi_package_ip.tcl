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

# Create the directories to package the IP
if {![file exists [file join $workDir cip]]} {
    file mkdir [file join $workDir cip]
}
if {![file exists [file join $workDir cip core2axi]]} {
    file mkdir [file join $workDir cip core2axi]
}

if {![file exists [file join $workDir cip core2axi rtl]]} {
    file mkdir [file join $workDir cip core2axi rtl]
}

set rtlFilesFull {}

# Copy the files into each folder
foreach f $rtlFiles {
    file copy -force [file join $rtlRoot $f] [file join $workDir cip core2axi rtl]
    lappend rtlFilesFull [file join $workDir cip core2axi rtl $f]
}

# Create project 
create_project -part xc7vx485tffg1761-2  -force core2axi [file join $workDir]
add_files -norecurse $rtlFilesFull

update_compile_order -fileset sources_1

ipx::package_project -root_dir [file join $workDir cip core2axi] -vendor "jonathan-rainer.com" -library Kuuga

