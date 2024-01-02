class CertificatersController < ApplicationController
  def index
    @certificaters = Certificater.all
  end
end
