#!/bin/bash
set -ex

# set env in local 
year=$(date +%Y)
month=$(date +%m)
week=$(date +%U)
date=$(date +%d)
slug=${year}-${week}
from_date=$(gdate '+%Y-%m-%d')
to_date=$(gdate '+%Y-%m-%d' --date '6 days')

post_dir=content/posts/$(expr $(date +%Y) / 10)x/${year}/${week}

# set env in global
echo "::set-env name=slug::${slug}"
echo "::set-env name=post_dir::${post_dir}"

# mkdir, hero alias
mkdir -p ${post_dir}/images
ln -s ../../../../../../src/assets/no-hero.png ${post_dir}/images/no-hero.png

# make blog file
erb from_date=${from_date} \
    to_date=${to_date} \
    slug=${slug} \
    src/templates/posts/index.md.erb > ${post_dir}/index.md
