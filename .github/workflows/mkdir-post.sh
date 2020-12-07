#!/bin/bash
set -ex

if [[ "$(uname)" == 'Darwin' ]]; then
    shopt -s expand_aliases
    alias date='gdate'
fi

sunday='sunday'
if [ $(date +%w) -ne 0 ] ; then
  sunday="next sunday"
fi

year=$(date +%Y --date "${sunday}")
week=$(date +%U --date "${sunday}")
slug=${year}-${week}
to_date=$(date '+%Y-%m-%d' --date "${sunday}")
from_date=$(date '+%Y-%m-%d' --date "6 day ago ${to_date}")
post_dir=content/posts/$(expr ${year} / 10)x/${year}/${week}

# set env in global(GitHub Actions)
echo "slug=${slug}" >> $GITHUB_ENV
echo "from_date=${from_date}" >> $GITHUB_ENV
echo "to_date=${to_date}" >> $GITHUB_ENV
echo "post_dir=${post_dir}" >> $GITHUB_ENV

# mkdir, hero alias
mkdir -p ${post_dir}/images
ln -s ../../../../../../src/assets/no-hero.png ${post_dir}/images/no-hero.png

# make blog file
erb from_date=${from_date} \
    to_date=${to_date} \
    slug=${slug} \
    post_dir=${post_dir} \
    src/templates/posts/index.md.erb > ${post_dir}/index.md
