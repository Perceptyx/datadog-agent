# $FreeBSD$

PORTNAME=	datadog-agent
DISTVERSION=	7.16.0
PORTREVISION=	8
CATEGORIES=	sysutils

MAINTAINER=	admins@perceptyx.com
COMMENT=	Datadog Agent

LICENSE=	BSD3CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	go>=1.11.5:lang/go \
		cmake>=3.12:devel/cmake

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>0:devel/py-yaml

USES=	python:3.7 go

DATADOG_PREFIX=	/opt/datadog-agent
LOGDIR?=	/var/log/datadog
ETCDIR=		${PREFIX}/etc/datadog-agent

USE_GITHUB=	yes
GH_ACCOUNT=	DataDog
GH_PROJECT=	datadog-agent
GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}
GH_SUBDIR=	src/github.com/DataDog/datadog-agent
GH_TAGNAME=	${DISTVERSION}

# For list of modules you can check:
# https://github.com/DataDog/datadog-agent/blob/${DISTVERSION}/Gopkg.toml
GH_TUPLE=	DataDog:agent-payload:4.24.0:agent_payload/src/github.com/DataDog/agent-payload \
					DataDog:gohai:master:gohai/src/github.com/DataDog/gohai \
					DataDog:zstd:v1.3.0:zstd/src/github.com/DataDog/zstd \
					DataDog:zstd:2b373cb:zstd_v0_5/src/github.com/DataDog/zstd.v0.5 \
					hashicorp:consul:v1.0.7:consul/src/github.com/hashicorp/consul \
					beevik:ntp:v0.2.0:ntp/src/github.com/beevik/ntp \
					cihub:seelog:v2.6:seelog/src/github.com/cihub/seelog \
					coreos:etcd:v3.2.23:etcd/src/github.com/coreos/etcd \
					coreos:go-semver:v0.2.0:go_semver/src/github.com/coreos/go-semver \
					moby:moby:v1.13.1:docker/src/github.com/docker/docker \
					containerd:containerd:v1.2.2:containerd/src/github.com/containerd/containerd \
					gogo:protobuf:v1.0.0:protobuf/src/github.com/gogo/protobuf \
					DataDog:mmh3:2cfb684:mmh3/src/github.com/DataDog/mmh3 \
					DataDog:viper:v1.7.0:viper/src/github.com/DataDog/viper \
					aws:aws-sdk-go:v1.12.79:aws_sdk_go/src/github.com/aws/aws-sdk-go \
					clbanning:mxj:v1.8:mxj/src/github.com/clbanning/mxj \
					dustin:go-humanize:9f541cc:go_humanize/src/github.com/dustin/go-humanize \
					fatih:color:v1.7.0:color/src/github.com/fatih/color \
					go-ini:ini:v1.37.0:ini/src/github.com/go-ini/ini \
					gorilla:mux:v1.6.2:mux/src/github.com/gorilla/mux \
					json-iterator:go:v1.1.5:json_iterator/src/github.com/json-iterator/go \
					kardianos:osext:ae77be6:osext/src/github.com/kardianos/osext \
					mholt:archiver:26cf5bb:archiver/src/github.com/mholt/archiver \
					patrickmn:go-cache:v2.1.0:go_cache/src/github.com/patrickmn/go-cache \
					shirou:gopsutil:v2.18.12:gopsutil/src/github.com/shirou/gopsutil \
					dsnet:compress:cc9eb1d:compress/src/github.com/dsnet/compress \
					fsnotify:fsnotify:v1.4.7:fsnotify/src/github.com/fsnotify/fsnotify \
					golang:snappy:2e65f85:snappy/src/github.com/golang/snappy \
					hashicorp:hcl:ef8a98b:hcl/src/github.com/hashicorp/hcl \
					magiconair:properties:v1.8.0:properties/src/github.com/magiconair/properties \
					mitchellh:mapstructure:bb74f1d:mapstructure/src/github.com/mitchellh/mapstructure \
					modern-go:concurrent:1.0.3:concurrent/src/github.com/modern-go/concurrent \
					modern-go:reflect2:1.0.1:reflect2/src/github.com/modern-go/reflect2 \
					nwaples:rardecode:e06696f:rardecode/src/github.com/nwaples/rardecode \
					pelletier:go-toml:v1.2.0:go_toml/src/github.com/pelletier/go-toml \
					pierrec:lz4:v2.0.3:lz4/src/github.com/pierrec/lz4 \
					spf13:afero:v1.1.1:afero/src/github.com/spf13/afero \
					DataDog:cast:1ee8c8b:cast/src/github.com/spf13/cast \
					spf13:cobra:v0.0.3:cobra/src/github.com/spf13/cobra \
					spf13:jwalterweatherman:7c0cea3:jwalterweatherman/src/github.com/spf13/jwalterweatherman \
					spf13:pflag:v1.0.1:pflag/src/github.com/spf13/pflag \
					stretchr:testify:v1.2.2:testify/src/github.com/stretchr/testify \
					ulikunitz:xz:v0.5.4:xz/src/github.com/ulikunitz/xz \
					urfave:negroni:v0.3.0:negroni/src/github.com/urfave/negroni \
					golang:net:97aa3a5:net/src/golang.org/x/net \
					golang:sys:61b9204:sys/src/golang.org/x/sys \
					golang:text:v0.3.0:text/src/golang.org/x/text \
					go-yaml:yaml:v2.2.2:yaml/src/gopkg.in/yaml.v2 \
					kubernetes:apimachinery:def12e6:apimachinery/src/k8s.io/apimachinery \
					coreos:go-systemd:v16:go_systemd/src/github.com/coreos/go-systemd \
					docker:go-connections:v0.3.0:connections/src/github.com/docker/go-connections \
					samuel:go-zookeeper:c4fab1a:go_zookeeper/src/github.com/samuel/go-zookeeper \
					ugorji:go:8c0409f:ugorji_go/src/github.com/ugorji/go \
					coreos:pkg:v4:coreos_pkg/src/github.com/coreos/pkg \
					DataDog:datadog-go:2.1.0:datadog_go/src/github.com/DataDog/datadog-go \
					DataDog:gopsutil:3ca45fa:datadog_gopsutil/src/github.com/DataDog/gopsutil \
					pkg:errors:v0.8.0:errors/src/github.com/pkg/errors \
					tinylib:msgp:v1.1.0:msgp/src/github.com/tinylib/msgp \
					philhofer:fwd:v1.0.0:fwd/src/github.com/philhofer/fwd \
					benesch:cgosymbolizer:bec6fe6:cgosymbolizer/src/github.com/benesch/cgosymbolizer \
					blabber:go-freebsd-sysctl:dcd5a22:go_freebsd_sysctl/src/github.com/blabber/go-freebsd-sysctl

USE_RC_SUBR=	${PORTNAME}-process ${PORTNAME}-trace ${PORTNAME}-sysprobe ${PORTNAME}

GID_FILES=	${PATCHDIR}/GIDs
UID_FILES=	${PATCHDIR}/UIDs

USERS=	dd-agent
GROUPS=	dd-agent

SUB_FILES=	pkg-message pkg-deinstall datadog-agent datadog-agent-trace datadog-agent-process
SUB_LIST=	LOGDIR=${LOGDIR} \
		PYTHON_SITELIBDIR=${PYTHON_SITELIBDIR} \
		PYTHON_CMD=${PYTHON_CMD} \
		PORTNAME=${PORTNAME} \
		ETCDIR=${ETCDIR}

PLIST_SUB+=	LOGDIR=${LOGDIR} \
		GROUP=${GROUPS} \
		PORTNAME=${PORTNAME} \
		ETCDIR=${ETCDIR}

OPTIONS_DEFINE=	DOCS APM CONSUL PYTHON EC2 ETCD GCE JMX LOG PROCESS ZK ZLIB
OPTIONS_DEFAULT= DOCS EC2 GCE LOG PYTHON PROCESS ZLIB

#DOCKER_DESC= 	Add Docker support (required by AutoDiscovery) -- This does not work in FreeBSD
#KUBELET_DESC=	Enable kubelet tag collection
#SYSTEMD_DESC=	Enable systemd journal log collection -- This does not work in FreeBSD
APM_DESC=	Make the APM agent execution available
CONSUL_DESC=	Enable consul as a configuration store
DOCS_DESC=	Install documentation
EC2_DESC= 	Enable EC2 hostname detection and metadata collection
ETCD_DESC= 	Enable Etcd as a configuration store
GCE_DESC= 	Enable GCE hostname detection and metadata collection
JMX_DESC= 	Enable the JMX-fetch bridge
LOG_DESC=	Enable the log agent
PROCESS_DESC=	Enable the process agent
PYTHON_DESC=	Embed the Python interpreter
ZK_DESC=	Enable Zookeeper as a configuration store
ZLIB_DESC=	Use zlib

APM_VARS=	agent_build_tags+=apm
CONSUL_VARS=	agent_build_tags+=consul
EC2_VARS=	agent_build_tags+=ec2
ETCD_VARS=	agent_build_tags+=etcd
GCE_VARS=	agent_build_tags+=gce
JMX_VARS=	agent_build_tags+=jmx
LOG_VARS=	agent_build_tags+=log
PROCESS_VARS=	agent_build_tags+=process
PYTHON_VARS=	agent_build_tags+=python
ZK_VARS=	agent_build_tags+=zk
ZLIB_VARS=	agent_build_tags+=zlib
USE_LDCONFIG=	${DATADOG_PREFIX}/embedded/lib

PYTHON_BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}invoke>=1.2.0_1:devel/py-invoke \
	${PYTHON_PKGNAMEPREFIX}reno>=2.9.2:textproc/py-reno \
	${PYTHON_PKGNAMEPREFIX}yaml>=5.1:devel/py-yaml \
	${PYTHON_PKGNAMEPREFIX}simplejson>=3.6.5:devel/py-simplejson \
	${PYTHON_PKGNAMEPREFIX}tornado>=3.2.2:www/py-tornado \
	${PYTHON_PKGNAMEPREFIX}requests>=2.21.0:www/py-requests \
	${PYTHON_PKGNAMEPREFIX}toml>=0.9.4:textproc/py-toml

PYTHON_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}prometheus-client>=0.7.1:net-mgmt/py-prometheus-client

LD_FLAG_X_PREFIX=	-X ${GO_WRKSRC}/pkg/version
LD_FLAG_STRING=	-s ${LD_FLAG_X_PREFIX}.Version=${DISTVERSION}
LD_FLAG_X_PREFIX=	-X ${GO_PKGNAME}/pkg/version
LD_FLAG_STRING= -s ${LD_FLAG_X_PREFIX}.AgentVersion=${DISTVERSION}

DATADOG_BINARIES=	agent dogstatsd process-agent trace-agent

do-build:
# Build rtloader (Previously called six)
	cd ${WRKSRC}/rtloader && ${SETENV} ${MAKE_ENV} ${BUILD_ENV} \
	cmake -DBUILD_DEMO:BOOL=OFF \
	-DCMAKE_INSTALL_PREFIX:PATH=${DATADOG_PREFIX}/embedded \
	-DDISABLE_PYTHON2=ON && make -C .

# Build go binaries
.for bin in ${DATADOG_BINARIES}
	(cd ${GO_WRKSRC}/cmd/${bin}; \
		${SETENV} ${MAKE_ENV} ${BUILD_ENV} GOPATH=${WRKSRC} \
		CGO_CFLAGS="-w -I${WRKSRC}/rtloader/include -I${WRKSRC}/rtloader/common" \
		CGO_LDFLAGS="-L${WRKSRC}/rtloader/rtloader" go build -tags \
		'${AGENT_BUILD_TAGS}' -o ${GO_WRKSRC}/cmd/${bin}/${bin} -ldflags "${LD_FLAG_STRING}")
.endfor

	# Generate config files
	go run ${GO_WRKSRC}/pkg/config/render_config.go agent-py3 \
		${GO_WRKSRC}/pkg/config/config_template.yaml \
		${GO_WRKSRC}/cmd/agent/dist/datadog.yaml

do-install:
	${MKDIR} ${STAGEDIR}${DATADOG_PREFIX}/bin/agent
	${MKDIR} ${STAGEDIR}${DATADOG_PREFIX}/embedded/bin
	${MKDIR} ${STAGEDIR}${DATADOG_PREFIX}/embedded/datadog_checks
	${MKDIR} ${STAGEDIR}${ETCDIR}

.for doc in README.md CHANGELOG.rst CONTRIBUTING.md LICENSE
	(${INSTALL_MAN} ${WRKSRC}/${doc} ${STAGEDIR}${DATADOG_PREFIX})
.endfor

	# Install binaries
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/process-agent/process-agent ${STAGEDIR}${DATADOG_PREFIX}/embedded/bin/process-agent
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/trace-agent/trace-agent ${STAGEDIR}${DATADOG_PREFIX}/embedded/bin/trace-agent
	${INSTALL_PROGRAM} ${GO_WRKSRC}/cmd/agent/agent	${STAGEDIR}${DATADOG_PREFIX}/bin/agent
	cd ${GO_WRKSRC}/cmd/agent && ${COPYTREE_SHARE} dist ${STAGEDIR}${DATADOG_PREFIX}/bin/agent
	cd ${GO_WRKSRC}/pkg/status/dist && ${COPYTREE_SHARE} templates ${STAGEDIR}${DATADOG_PREFIX}/bin/agent/dist
	${CP} ${GO_WRKSRC}/cmd/agent/dist/datadog.yaml ${STAGEDIR}${ETCDIR}/datadog.yaml.sample

	# Install rtloader library
	cd ${WRKSRC}/rtloader && make -C . install DESTDIR=${STAGEDIR}

post-install:
	${STRIP_CMD} ${STAGEDIR}/opt/datadog-agent/embedded/lib/libdatadog-agent-rtloader.so.0.1.0
	${STRIP_CMD} ${STAGEDIR}/opt/datadog-agent/embedded/lib/libdatadog-agent-three.so
	${MKDIR} ${STAGEDIR}${LOGDIR}

.include <bsd.port.mk>
