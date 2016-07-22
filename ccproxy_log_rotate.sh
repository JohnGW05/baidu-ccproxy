dir=`dirname $0`
dir=`dirname $dir`
echo "runtime: "
date

# mv log
now_time=`date "+%Y%m%d%H"`
mv ${dir}/log/ccproxy.log ${dir}/log/ccproxy.log.$now_time
mv ${dir}/log/ccproxy.isis.log ${dir}/log/ccproxy.isis.log.$now_time

# reopen log
pname_pattern='^./bin/ccproxy'
pkill -HUP -f ${pname_pattern}
pkill_status=$?

# clean too old log
log_keep_min=`expr 60 \* 24 \* 1`
find ${dir}/log/ -name 'ccproxy.log.2*' -amin +${log_keep_min} 2>/dev/null | xargs rm -f
find ${dir}/log/ -name 'ccproxy.isis.log.2*' -amin +${log_keep_min} 2>/dev/null | xargs rm -f
if [ $pkill_status -ne 0 ]
then
    echo "log reopen error"
    exit 1
fi
