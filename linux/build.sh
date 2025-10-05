cp /boot/config-$(uname -r) .config
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --set-str CONFIG_LOCALVERSION "-memtis"
echo "CONFIG_HTMM=y" >> .config
scripts/config --disable CONFIG_DEBUG_INFO_BTF
yes "" | make oldconfig
scripts/config --disable CONFIG_DEBUG_INFO_BTF
make -j40;  sudo make modules_install -j$(nproc); sudo make install

