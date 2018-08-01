FROM python:3-slim
MAINTAINER ramana
EXPOSE 5000
COPY . /
WORKDIR /
RUN pip  install -r requirements.txt
#WORKDIR /
RUN emulator.py > /dev/null 2<&1 &
CMD [python","emulator.py"]
#CMD ["curl","-s","localhost:5000"]
ENTRYPOINT python emulator.py
