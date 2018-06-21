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
        @tipo.aom_atributos.each do |atrib|
            atrib.destroy
        end
        @tipo.destroy
        redirect_to aom_path
    end

    def gerar_json
        tipos = AomTipo.all
        dados = []
        tipos.each do |tipo|
            obj = {"nome_tipo": tipo.nome_tipo}
            atribsvec = []
            tipo.aom_atributos.each do |atrib|
                atribsvec.push({"nome": atrib.nome, "hint": atrib.descricao})
            end
            obj["atributos"] = atribsvec
            dados.push(obj)
        end
        render :json => dados
    end

    private 
    def parametros_tipo 
        params.require(:aom_tipo).permit(:nome_tipo, :descricao)
    end

end
