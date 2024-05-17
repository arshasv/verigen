FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
    iverilog \
    curl \
    dos2unix \
    && apt-get clean

WORKDIR /app

COPY tb.sh .
COPY halfadder.v .
COPY halfadder_tb.v .

RUN dos2unix tb.sh halfadder.v halfadder_tb.v

RUN chmod +x tb.sh

CMD ["./tb.sh"]
