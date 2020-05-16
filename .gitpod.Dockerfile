FROM gitpod/workspace-full

# Install Git LFS
RUN brew install git-lfs && git lfs install

# add alias for git clone
RUN git config --global alias.clone 'lfs clone'
