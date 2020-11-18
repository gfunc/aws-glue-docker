docker stop zepglue && docker rm zepglue
docker build -t test/zeppelin-glue:1.0 .
docker run -p 9090:9090 -p 7077:7077 -p 10080:8080 -d --name zepglue test/zeppelin-glue:1.0