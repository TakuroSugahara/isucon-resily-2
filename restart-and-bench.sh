# nginx のログを削除
echo ":: CLEAR LOGS       ====>"
sudo truncate -s 0 -c /var/log/nginx/access.log
sudo truncate -s 0 -c /var/lib/mysql/mysqld-slow.log

# 各種サービスの再起動
echo
echo ":: RESTART SERVICES ====>"
sudo systemctl restart mysql

sudo systemctl daemon-reload
sudo systemctl restart isu-go.service

sudo systemctl restart nginx

sleep 5
echo ":: PLEASE RUN BENCH ====>"
read

echo
echo ":: ACCESS LOG       ====>"
sudo cat /var/log/nginx/access.log | alp --sum -r -f /var/log/nginx/access.log > /tmp/access.txt
cat /tmp/access.txt

echo
echo ":: SLOW LOG       ====>"
# pt-query-digest /var/lib/mysql/mysqld-slow.log > /tmp/digest.txt
# cat /tmp/digest.txt

