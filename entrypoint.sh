#!/bin/sh

echo ""
echo "========================================="
echo " Avex Neovim Configuration"
echo "========================================="
echo ""
echo "Recommanded: copy this configuration to your system:"
echo ""
echo "docker run --rm -v ~/.config/nvim:/install_destination devxam5/avex-nvim \\"
echo "sh -c \"cp -rv /root/.config/nvim/. /install_destination\""
echo ""
echo "⚠ This will overwrite your existing config."
echo "Backup first:"
echo "mv ~/.config/nvim ~/.config/nvim_backup"
echo ""
echo "Recommanded for good healthcheck."

exec "$@"
