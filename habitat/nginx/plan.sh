# Copied from core/nginx until I can figure out a good way to "wrap" services and provide
#  our own config

pkg_name="icewatch-nginx"
pkg_version="1.10.1"
pkg_origin="uafgina"
pkg_maintainer="UAF GINA <support+habitat@gina.alaska.edu>"
pkg_license=('BSD')
pkg_description="NGINX web server."
pkg_source=https://nginx.org/download/nginx-${pkg_version}.tar.gz
pkg_dirname=nginx-${pkg_version}
pkg_upstream_url=https://nginx.org/
pkg_shasum=1fd35846566485e03c0e318989561c135c598323ff349c503a6c14826487a801
pkg_deps=(core/glibc core/libedit core/ncurses core/zlib core/bzip2 core/openssl core/pcre)
pkg_build_deps=(core/gcc core/make core/coreutils)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(sbin)
pkg_include_dirs=(include)
pkg_svc_run="sbin/nginx"
pkg_svc_user="root"
pkg_expose=(80 443)

do_build() {
  build_line "Building at $(pwd)"
  ./configure --prefix="$pkg_prefix" \
    --conf-path="$pkg_svc_config_path/nginx.conf" \
    --sbin-path="$pkg_prefix/bin/nginx" \
    --pid-path="$pkg_svc_var_path/nginx.pid" \
    --lock-path="$pkg_svc_var_path/nginx.lock" \
    --user=hab \
    --group=hab \
    --http-log-path=/dev/stdout \
    --error-log-path=stderr \
    --http-client-body-temp-path="$pkg_svc_var_path/client-body" \
    --http-proxy-temp-path="$pkg_svc_var_path/proxy" \
    --http-fastcgi-temp-path="$pkg_svc_var_path/fastcgi" \
    --http-scgi-temp-path="$pkg_svc_var_path/scgi" \
    --http-uwsgi-temp-path="$pkg_svc_var_path/uwsgi" \
    --with-ipv6 \
    --with-pcre \
    --with-pcre-jit \
    --with-file-aio \
    --with-stream=dynamic \
    --with-mail=dynamic \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_addition_module \
    --with-http_degradation_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_secure_link_module \
    --with-http_sub_module \
    --with-http_slice_module \
    --with-cc-opt="$CFLAGS" \
    --with-ld-opt="$LDFLAGS"

  make
}

do_install() {
  mkdir -p "$pkg_prefix/sbin"
  cp "$HAB_CACHE_SRC_PATH/$pkg_dirname/objs/nginx" "$pkg_prefix/sbin"
}