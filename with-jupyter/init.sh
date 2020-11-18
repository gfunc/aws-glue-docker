docker stop jupglue && docker rm jupglue
docker build -t test/jupyter-glue:1.0 .
docker run -p 10089:10089 -p 7077:7077 -p 10080:8080 -p 10081:8081 -d --name jupglue -i -i test/jupyter-glue:1.0