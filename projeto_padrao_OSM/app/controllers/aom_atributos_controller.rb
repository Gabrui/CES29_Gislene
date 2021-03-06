class AomAtributosController < ApplicationController
    def criar
        @tipo = AomTipo.find(params[:aom_atributo]["idtipo"])
        @atributo = @tipo.aom_atributos.create(parametros_atributos)
        redirect_to tipo_path(@tipo)
  end

  def apagar
    @atrib = AomAtributo.find(params[:id])
    @tipo = @atrib.aom_tipo
    @atrib.destroy
    redirect_to tipo_path(@tipo)
  end

  private
    def parametros_atributos
      params.require(:aom_atributo).permit(:nome, :descricao)
    end
end
