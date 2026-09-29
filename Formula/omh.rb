# typed: strict
# frozen_string_literal: true

# Homebrew formula for the OMH maintenance command.
class Omh < Formula
  include Language::Python::Virtualenv

  desc "Hermes-native workflow skills and maintenance CLI"
  homepage "https://rlaope.github.io/oh-my-hermes/"
  url "https://github.com/rlaope/oh-my-hermes/releases/download/v3.0.0/oh_my_hermes-3.0.0-py3-none-any.whl"
  version "3.0.0"
  sha256 "6a05f40a89d4c35927855c4e477099097656c878027efc753a598202e6d1974f"
  license "MIT"

  depends_on "python@3.14"

  def install
    ENV["PIP_NO_INDEX"] = "1"
    wheel = buildpath/"oh_my_hermes-#{version}-py3-none-any.whl"
    cp cached_download, wheel
    python = formula_opt_bin("python@3.14")/"python3.14"
    venv = virtualenv_create(libexec, python)
    venv.pip_install_and_link wheel, build_isolation: false
  end

  test do
    assert_match "usage:", shell_output("#{bin}/omh --help")
  end
end
