VERSION=2.1.1
PROJECT=tsouhaieb
APP=thingsboard_healthcheck_log

build:
	#cp ../../application/target/thingsboard.deb .
	docker build --pull -t ${PROJECT}/${APP}:${VERSION} -t ${PROJECT}/${APP}:latest .
	#rm thingsboard.deb

push: build
	docker push ${PROJECT}/${APP}:${VERSION}
	docker push ${PROJECT}/${APP}:latest
