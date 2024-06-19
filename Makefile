PUBLIC_FOLDER = public

all: ${PUBLIC_FOLDER}

clean:
	rm -Rf ${PUBLIC_FOLDER} resources/_gen

build:
	hugo

validate: build
	vnu --skip-non-html ${PUBLIC_FOLDER}
	vnu --skip-non-css ${PUBLIC_FOLDER}

${PUBLIC_FOLDER}: build
	find public -type f \( -name '*.html' -o -name '*.css' -o -name '*.xml' -o -name '*.txt' \) \
		-exec gzip -k -f -9 {} \;                                                        \
		-exec brotli -q 11 {} \;                                                            \
		-exec zstd -q --ultra -22 {} \;
