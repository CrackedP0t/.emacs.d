export conf_dir="${HOME}/.zshconf"

for file in ${conf_dir}/0*.zsh; do
    source ${file}
done
