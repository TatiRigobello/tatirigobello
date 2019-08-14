CREATE TYPE sigh.t_ListaIDClienteProntuarios AS(
IDClienteIntegracaoRet VARCHAR ,
IDClienteIntegracaoNovoRet VARCHAR ,
NumProntuarioRet VARCHAR ,
EndProntuarioRet VARCHAR
);
CREATE TYPE sigh.t_UNIFICACAO_IDCLIENTE_AOL AS (
	codigoMensagemRetorno VARCHAR,
	descricaoMensagemRetorno VARCHAR,
	ListaIDClienteProntuarios sigh.t_ListaIDClienteProntuarios
);


CREATE or replace FUNCTION SIGH.UNIFICACAO_IDCLIENTE_AOL(dataAtualizacao VARCHAR ) RETURNS SETOF  sigh.t_UNIFICACAO_IDCLIENTE_AOL AS $$

	DECLARE RetUnificacao sigh.t_UNIFICACAO_IDCLIENTE_AOL;
	
	declare ListaIDClienteProntuarios_  sigh.t_ListaIDClienteProntuarios;
	declare CodigoMensagemRetorno VARCHAR;
	declare DescricaoMensagemRetorno VARCHAR;
	
BEGIN
      /* dados virão das consultas ás tabelas dos pacientes, por enquanto está fixo */

        ListaIDClienteProntuarios_.IDClienteIntegracaoRet ='111' ;
	ListaIDClienteProntuarios_.IDClienteIntegracaoNovoRet ='222' ;
	ListaIDClienteProntuarios_.NumProntuarioRet   ='333';
	ListaIDClienteProntuarios_.EndProntuarioRet ='444545';

      /* Códigos vão retornar de acordo com o resultado das queries que serão implementadas*/ 
      -- if .... then 
	CodigoMensagemRetorno = '0';
	DescricaoMensagemRetorno = 'Foram encontrados 8 registros.';
	-- else...
	CodigoMensagemRetorno='1';
	DescricaoMensagemRetorno=' Não foram encontrados registros.';
     -- aqui será configurado a validacao das datas , por enquanto está fixo
	IF (dataAtualizacao > '20190515' ) THEN 
	   CodigoMensagemRetorno=  '2';
	   DescricaoMensagemRetorno =' A data de atualização não pode ser superior à data atual.';
	 end if ;

/*EXECEÇÃO
CodigoMensagemRetorno ='1';
DescricaoMensagemRetorno=' erro do Oracle: ORA-999999: ....'
*/

	FOR RetUnificacao IN (SELECT CodigoMensagemRetorno,DescricaoMensagemRetorno,ListaIDClienteProntuarios_)  LOOP
	  -- retorno vai ser um type com os campos CodigoMensagemRetorno e DescricaoMensagemRetorno 
	  --ListaIDClienteProntuarios_ : type que vai receber   IDClienteIntegracaoRet  IDClienteIntegracaoNovoRet  NumProntuarioRet  EndProntuarioRet 
		RETURN NEXT RetUnificacao;
	END LOOP;
	
	RETURN;
END;
$$ LANGUAGE 'plpgsql';

select * from SIGH.UNIFICACAO_IDCLIENTE_AOL ('20190801')
 