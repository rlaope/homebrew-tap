# typed: strict
# frozen_string_literal: true

# Homebrew formula for the OMH maintenance command.
class Omh < Formula
  include Language::Python::Virtualenv

  desc "Hermes-native workflow skills and maintenance CLI"
  homepage "https://rlaope.github.io/oh-my-hermes/"
  url "https://github.com/rlaope/oh-my-hermes/releases/download/v2.0.1/oh_my_hermes-2.0.1-py3-none-any.whl"
  version "2.0.1"
  sha256 "ae46ead58c5a865ee8a872254ed1411ee896539540254703f0f43d25cd61d10f"
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
