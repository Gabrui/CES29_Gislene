class NossoaomController < ApplicationController
    def paginainicial
        @tipos = ObjetoType.all
    end
end
