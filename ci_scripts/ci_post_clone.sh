#!/bin/sh

#  ci_post_clone.sh
#  Interface
#
#  Created by 김도형 on 2023/09/06.
#  

defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES

curl https://mise.jdx.dev/install.sh | sh

mise install

mise x tuist clean
mise x tuist install
mise x tuist generate
