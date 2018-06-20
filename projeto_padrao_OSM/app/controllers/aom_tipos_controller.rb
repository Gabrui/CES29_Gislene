class AomTiposController < ApplicationController
    def paginainicial
        @tipos = AomTipo.all
    end

    def novo
        @tipo_novo = AomTipo.new
    end

    def criar
        @tipo = AomTipo.new(parametros_tipo) 
        if @tipo.save 
          redirect_to "/aom_tipos" 
        else 
          render "novo"
        end 
      end

    private 
    def parametros_tipo 
        params.require(:aom_tipo).permit(:nome_tipo) 
    end

end
