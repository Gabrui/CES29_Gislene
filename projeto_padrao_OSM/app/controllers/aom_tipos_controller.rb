class AomTiposController < ApplicationController
    layout "nossoaom"

    def paginainicial
        @tipos = AomTipo.all
    end

    def novo
        @tipo_novo = AomTipo.new
    end

    def criar
        @tipo = AomTipo.new(parametros_tipo) 
        if @tipo.save 
          redirect_to "/aom"
        else 
          render "novo"
        end 
      end

    def mostrar
        @tipo_encontrado = AomTipo.find(params[:id])
        @atributos = @tipo_encontrado.aom_atributos
    end

    def apagar
        @tipo = AomTipo.find(params[:id])
        @tipo.destroy
        redirect_to aom_path
    end

    def gerar_json
        dados = AomTipo.all
        render :json => dados
    end

    private 
    def parametros_tipo 
        params.require(:aom_tipo).permit(:nome_tipo, :descricao)
    end

end
