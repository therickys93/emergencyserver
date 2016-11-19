FROM therickys93/ubuntu14swiftenv

RUN swiftenv install 3.0 && swiftenv global 3.0

WORKDIR /vapor
ADD . /vapor
EXPOSE 80
RUN swift build

CMD .build/debug/App
