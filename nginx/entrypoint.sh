#!/bin/bash
set -eu

function substitute_env_vars() {
    output_dir=$1
    shift
    files=$@

    function fill_in() {
        perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : "\${$1}"/eg' "${1}"
    }

    function output_filename {
        local destname=$(basename "${1}" '.tmpl')
        echo "${output_dir}/${destname}"
    }

    for file in $files; do
        fill_in "${file}" > $(output_filename "${file}")
    done
}

function render_templates() {
    indir="${1}"
    outdir="${2}"

    function template_files() {
        find "${indir}" \
            -mindepth 1 \
            -maxdepth 1 \
            -name '*.tmpl' \
            -print0
    }

    function non_template_files() {
        find "${indir}" \
            -mindepth 1 \
            -maxdepth 1 \
            -not \
            -name '*.tmpl' \
            -print0
    }

    rm -rf "${outdir}"
    mkdir -p "${outdir}"
    template_files | xargs -0 bash -c 'substitute_env_vars "${outdir}"'
    non_template_files | xargs -0 -I{} ln -s {} "${outdir}"
}

export -f substitute_env_vars

render_templates /etc/nginx/sites-templates /etc/nginx/conf.d

exec "$@"
