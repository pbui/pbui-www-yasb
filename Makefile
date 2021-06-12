COMMON= 	$(shell ls static/yaml/*.yaml) 	\
		  scripts/yasb.py 			\
		  templates/base.tmpl
DEPLOY=		public
RSYNC_FLAGS= 	-rv --copy-links --progress --exclude="cs.*.*" --exclude="idis.*.*" --exclude="*.swp" --exclude="*.yaml"
YAML=		$(shell ls pages/*.yaml pages/*/*.yaml)
HTML= 		${YAML:.yaml=.html}

%.html:		%.yaml ${COMMON}
	./scripts/yasb.py $< > $@

all:		${HTML}

deploy:		all
	cp -frv pages/*.html		${DEPLOY}/.

	mkdir -p ${DEPLOY}/research
	cp -frv pages/research/*	${DEPLOY}/research/.

	mkdir -p ${DEPLOY}/teaching
	cp -frv pages/teaching/*	${DEPLOY}/teaching/.

	mkdir -p ${DEPLOY}/static
	cp -frv static/*		${DEPLOY}/static/.
	cp -frv static/ico/favicon.ico	${DEPLOY}/.

	mkdir -p ${DEPLOY}/common
	cp -frv static/common/*		${DEPLOY}/common/.

install:	deploy
	lftp -c "open www3ftps.nd.edu; mirror -c -R -L public www"

clean:
	rm -f ${HTML}
