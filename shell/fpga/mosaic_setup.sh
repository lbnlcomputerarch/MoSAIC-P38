demo=$1
hex=$2
run=$3
post=$4
echo "#############################"
echo "# Runnning Demo: $demo"
echo "#############################"
dir_local=`pwd`
echo "INFO: Local directory, $dir_local"

#- Parsing options
if [ "$demo" = "trisolver" ];then
   dir_exec="${dir_local}/asynch_trisolv"
   dir_hex="${dir_local}/../../tools/picorv_c/c_demo"
   hex_perl="./async_trisolve.pl"
   get_readelf="cp ${dir_hex}/temp_files/async_trisolve_0.readelf ."
   post_proc="./post_proc_read_mem_log.pl -cfile=async_trisolve"
elif [ "$demo" = "spmv" ];then
   dir_exec="${dir_local}/spmv"
   dir_hex="${dir_local}/../../tools/picorv_c/c_demo"
   hex_perl="./spmv.pl"
   get_readelf="cp ${dir_hex}/temp_files/spmv_0.readelf ."
   post_proc="./post_proc_read_mem_log.pl -cfile=spmv"
else 
   echo "Error. Choose a Demo"
   echo "The options are trisolver or spmv"
   exit 1
fi

if [ "$hex" = "1" ];then
   echo "#####################################"
   echo "# Generate HEX files for RISCV cores"
   echo "#####################################"
   cd $dir_hex
   $hex_perl
   cp *.hex ${dir_local}/
   cd $dir_local
   $get_readelf
fi

echo "###########################################"
echo "# Generate executables for PCIE interface"
echo "###########################################"
cd $dir_exec
echo "INFO: Cleaning up"
rm set_system read_mem
echo "INFO: Executable for writing memories and registers"
gcc set_system.c pcimem.c -o set_system 2> set_system_gcc.log
echo "INFO: Executable for reading memories and registers"
gcc read_mem.c pcimem.c -o read_mem 2> read_mem_gcc.log
cd $dir_local
#- Remove symbolic links
rm set_system
rm read_mem
#- Create symbolic links
ln -s ${dir_exec}/set_system set_system
ln -s ${dir_exec}/read_mem read_mem

if [ "$run" = "1" ];then
   echo "######################################"
   echo "# Load Firmware "
   echo "######################################"
   sudo ./set_system 2>&1 | tee set_system.log
   echo "######################################"
   echo "# Read packet count and memories "
   echo "######################################"
   #- Get diagnostics
   sudo ./read_mem | grep -v 'Reading' | grep -v 'Writing' | grep -v 'Data'
   sudo ./read_mem | grep Data 2>&1 | tee read_mem.log
fi 

echo "######################################"
echo "# Post-processing "
echo "######################################"

if [ "$post" = "1" ];then
$post_proc
python3 visualize_packets.py
fi
