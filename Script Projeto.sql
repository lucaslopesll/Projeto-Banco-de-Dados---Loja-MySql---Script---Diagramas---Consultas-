begin;

CREATE TABLE endereco(
end_id varchar(80)		NOT NULL,
end_cep varchar(10) 	NOT NULL,
end_numero integer,
end_rua varchar(80)		NOT NULL,
end_cidade varchar(20)	NOT NULL,
end_bairro varchar(20)	NOT NULL,
PRIMARY KEY (end_id)
);

CREATE TABLE transportadora(
transp_cod varchar(10) 	NOT NULL,
transp_nome varchar(50) NOT NULL,
PRIMARY KEY (transp_cod)
);

CREATE TABLE Fornecedor(
forn_cod varchar(10) 		NOT NULL,
forn_nome varchar(10)		NOT NULL,
forn_telefone varchar(15)	NOT NULL,
PRIMARY KEY(forn_cod)
);

CREATE TABLE Comprador(
comp_cod varchar(10) NOT NULL,
comp_nome varchar(50) NOT NULL,
UNIQUE (comp_cod),
PRIMARY KEY (comp_cod)
);

CREATE TABLE Empresa(
emp_cnpj varchar(20)			NOT NULL,
emp_nomefantasia varchar(30)	NOT NULL,
emp_razaosocial varchar	(30)	NOT NULL,
emp_end_fk varchar(10), constraint foreign key (emp_end_fk) references Endereco (end_id),
UNIQUE(emp_cnpj), 			
PRIMARY KEY(emp_cnpj)
);
CREATE TABLE Funcionario(
func_cod varchar(10)		NOT NULL,
func_tipo varchar(20) 		NOT NULL,
func_nome varchar(50)		NOT NULL,
func_comp_fk varchar(10), 	constraint foreign key (func_comp_fk) references Comprador (comp_cod),
UNIQUE(func_cod),
PRIMARY KEY(func_cod)
);

CREATE TABLE Pedido(
ped_numero integer NOT NULL,
ped_valor numeric(6,2) NOT NULL,
PRIMARY KEY (ped_numero)
);

CREATE TABLE NotaFiscal(
not_numeronf integer NOT NULL,
not_valor numeric(6,2)    NOT NULL,
not_dataemissao date NOT NULL,
not_duplicatas integer,
not_valoripi float,
not_forn_fk varchar(20), constraint foreign key (not_forn_fk) references Fornecedor (forn_cod),
not_ped_fk integer, constraint foreign key (not_ped_fk) references Pedido(ped_numero),
PRIMARY KEY (not_numeronf)
);

CREATE TABLE Produto(
prod_cod varchar(10) NOT NULL,
prod_descricao varchar(50) NOT NULL,
prod_preco numeric(6,2) NOT NULL,
prod_ncm varchar(50) NOT NULL,
prod_nome varchar(80) NOT NULL,
UNIQUE(prod_cod),
PRIMARY KEY (prod_cod)
);
CREATE TABLE PossuiEndTransp(
possui_end_fk varchar(10) NOT NULL, constraint foreign key (possui_end_fk) references endereco (end_id),
possui_trans_fk varchar(10) NOT NULL, constraint foreign key (possui_trans_fk) references transportadora (transp_cod),
PRIMARY KEY (possui_trans_fk, possui_end_fk)
);
CREATE TABLE EncaminhaTranspNota(
enc_transp_fk varchar(10) NOT NULL, constraint foreign key (enc_transp_fk) references transportadora (transp_cod),
enc_nota_fk integer NOT NULL, constraint foreign key (enc_nota_fk) references notafiscal (not_numeronf),
enc_datasaida date NOT NULL, 
enc_datachegada date NOT NULL,
PRIMARY KEY (enc_transp_fk , enc_nota_fk)
);
CREATE TABLE PossuiEndFornecedor(
poss_end_fk varchar(10) NOT NULL, constraint foreign key (poss_end_fk) references endereco (end_id),
poss_for_fk varchar(10) NOT NULL, constraint foreign key (poss_for_fk) references fornecedor (forn_cod),
PRIMARY KEY (poss_end_fk, poss_for_fk)
);
CREATE TABLE RotaEndNota(
rot_end_fk varchar(10) NOT NULL, constraint foreign key (rot_end_fk) references endereco (end_id),
rot_nota_fk integer NOT NULL, constraint foreign key (rot_nota_fk) references notafiscal (not_numeronf),
PRIMARY KEY (rot_end_fk,rot_nota_fk)
);
CREATE TABLE PossuiFuncEmpresa(
pos_funcemp_fk varchar(10) NOT NULL, constraint foreign key (pos_funcemp_fk) references funcionario (func_cod),
pos_empfunc_fk varchar(40) NOT NULL, constraint foreign key (pos_empfunc_fk) references empresa (emp_cnpj),
PRIMARY KEY (pos_funcemp_fk, pos_empfunc_fk)
);
CREATE TABLE RealizaPedidoComprador(
real_ped_fk integer NOT NULL, constraint foreign key (real_ped_fk) references pedido (ped_numero),
real_comp_fk varchar(10) NOT NULL, constraint foreign key (real_comp_fk) references comprador(comp_cod),
real_datacompra date NOT NULL,
PRIMARY KEY (real_ped_fk, real_comp_fk)
);
CREATE TABLE ConteudoProdutoPedido(
prodcod_ped_fk varchar(10) NOT NULL, constraint foreign key (prodcod_ped_fk) references produto (prod_cod),
pedcod_prod_fk integer NOT NULL, constraint foreign key (pedcod_prod_fk) references pedido (ped_numero),
cont_quantidade integer NOT NULL,
PRIMARY KEY (prodcod_ped_fk, pedcod_prod_fk)
);
commit;

begin;
INSERT INTO Endereco VALUES ('0001E', '45584-544', 25,'Star wars', 'Ipiau', 'João das tantas');
INSERT INTO Endereco VALUES ('0002E', '17502-220', 474,'Paraiso das estrelas', 'Ceará', 'Salgado filho');
INSERT INTO Endereco VALUES ('0003E', '71994-065', 12,'Conjunto sha', 'Brasilia', 'Centro');
INSERT INTO Endereco VALUES ('0004E', '77060-380', 65,'Santa tereza', 'Palmas', 'Jardim Santa Barbara');
INSERT INTO Endereco VALUES ('0005E', '69082-621', 633,'Beco uirapuru', 'Manaus', 'Coroado');
INSERT INTO Endereco VALUES ('0006E', '69312-175', 4,'Avenida princesa isabel', 'Boa vista', 'Caimbé');
INSERT INTO Endereco VALUES ('0007E', '69035-640', 74,'Rua da properidade', 'Manaus', 'Compensa');
INSERT INTO Endereco VALUES ('0008E', '69028-324', 1,'Rua 11', 'Manaus', 'Flores');
INSERT INTO Endereco VALUES ('0009E', '57039-760', 98,'José de souza', 'Maceio', 'Ipioca');
INSERT INTO Endereco VALUES ('0010E', '35500-238', 42,'Rua bório', 'Divinópolis', 'São joao de Deus');
INSERT INTO Endereco VALUES ('0011E', '80814-995', 13,'Rua Treze de maio', 'Juazeiro', 'Boa vista');
INSERT INTO Endereco VALUES ('0012E', '78468-874', 54,'Rua Conjunto', 'São Cristovão', 'Industrial');
INSERT INTO Endereco VALUES ('0013E', '86069-845', 1696,'Rua Eres', 'Bela Vista', 'Bom despacho');
INSERT INTO Endereco VALUES ('0014E', '89680-748', 784,'Andar 10', 'Aracaju', 'São rominho');
INSERT INTO Endereco VALUES ('0015E', '98787-349', 4528,'Rua B', 'Arapiraca', 'São José');
INSERT INTO Endereco VALUES ('0016E', '59133-174', 5,'Rua Amelia Amado', 'Palhoça', 'Conde');
INSERT INTO Endereco VALUES ('0017E', '47815-984', 7945,'Rua Getulio', 'João Pessoa', 'São benedito');
INSERT INTO Endereco VALUES ('0018E', '68741-149', 657,'Rua Presidente Vargas', 'João Pessoa', 'Complexo Industrial');
INSERT INTO Endereco VALUES ('0019E', '91736-578', 88,'Rua Otto Alencar', 'Ilheús', 'Bom retiro');
INSERT INTO Endereco VALUES ('0020E', '14675-478', 1574,'Rua do bobo', 'Ubaitaba', 'Telebahia');
INSERT INTO Endereco VALUES ('0001F', '68787-674', 98,'Rua do medo', 'Brumado', 'Santo Amaro');
INSERT INTO Endereco VALUES ('0002F', '45545-000', 87,'Rua Edvaldo macedo', 'Brás', 'José Alencar');
INSERT INTO Endereco VALUES ('0003F', '65080-094', 650,'Fazenda1', 'Campina Grande', 'Boa vista');
INSERT INTO Endereco VALUES ('0004F', '98010-330', 218,'Praça Tenente Laerte', 'Cruz Alta', 'Brenner');
INSERT INTO Endereco VALUES ('0005F', '05886-050', 528,'Travessa Antonio Cirullo', 'São Paulo', 'Jardim Dom José');
INSERT INTO Endereco VALUES ('0006F', '69153-140', 446,'Rua Itapiranga', 'Paritins', 'Palmares');
INSERT INTO Endereco VALUES ('0007F', '57051-903', 705,'Rua Comendador Palmeira', 'Maceió', 'Farol');
INSERT INTO Endereco VALUES ('0008F', '57010-773', 862,'Rua Pedro Timoteo', 'Maceió', 'Trapiche da barra');
INSERT INTO Endereco VALUES ('0009F', '65092-164', 406,'Rua da Pirraçeira', 'São Luís', 'Mata de Itapera');
INSERT INTO Endereco VALUES ('0010F', '78740-036', 535,'Rua Armando Fajardo', 'Rondonópolis', 'Vila Aurora');
INSERT INTO Endereco VALUES ('0011F', '30120-060', 748,'Rua dos carijós', 'Belo Horizonte', 'Centro');
INSERT INTO Endereco VALUES ('0012F', '68700-216', 877,'Travessa Antonio Ferreira', 'Capanema', 'Igrejinha');
INSERT INTO Endereco VALUES ('0013F', '29946-490', 497,'Avenida Esbeltalina', 'São Mateus', 'Guriri norte');
INSERT INTO Endereco VALUES ('0014F', '30130-005', 55,'Avenida Afonso pena', 'Brumado', 'Boa viagem');
INSERT INTO Endereco VALUES ('0015F', '06709-015', 25,'Rodovia Raposo Tavares', 'Cotia', 'Lageadinho');
INSERT INTO Endereco VALUES ('0016F', '04302-021', 147,'Rua Paracatu', 'São Paulo', 'Parque Industrial');
INSERT INTO Endereco VALUES ('0017F', '01045-001', 74,'Praça da republica', 'São Paulo', 'República');
INSERT INTO Endereco VALUES ('0018F', '30130-005', 130,'Avenida Afonso Pena', 'Ibirapitanga', 'Bairro novo');
INSERT INTO Endereco VALUES ('0019F', '64000-290', 2549,'Rua Arlindo Nogueira', 'Teresina', 'Centro');
INSERT INTO Endereco VALUES ('0020F', '62011-111', 115,'Rua Domingos Ferreira', 'Apuarema', 'ACM');
INSERT INTO Endereco VALUES ('0001T', '28035-042', 69,'Escudo', 'Guará', 'Barra da Jangada');
INSERT INTO Endereco VALUES ('0002T', '75904-100', 242,'Rua Honório Quintiliano', 'Rio Verde', 'Martins');
INSERT INTO Endereco VALUES ('0003T', '76829-470', 808,'Rua Ciro Monteiro', 'Porto Velho', 'Tancredo Neves');
INSERT INTO Endereco VALUES ('0004T', '88305-100', 15,'Rua Blumenau', 'Itajaí', 'São João');
INSERT INTO Endereco VALUES ('0005T', '69313-048', 616,'Rua Postal', 'Boa vista', 'Jóquei Clube');
INSERT INTO Endereco VALUES ('0006T', '94824-140', 23,'Santo André', 'Alvorada', 'Sumaré');
INSERT INTO Endereco VALUES ('0007T', '40230-086', 336,'Avenida das Esmeraldas', 'Salvador', 'Federação');
INSERT INTO Endereco VALUES ('0008T', '28605-320', 5,'Rua Maria Thuller', 'Nova Friburgo', 'Sitio Jacina');
INSERT INTO Endereco VALUES ('0009T', '57073-479', 295,'Rua I', 'Una', 'Clube B');
INSERT INTO Endereco VALUES ('0010T', '74974-330', 506,'Rua Rio Grande', 'Aparecida', 'Setor dos Estados');
INSERT INTO Endereco VALUES ('0011T', '75802-095', 17,'Avenida Tocatins', 'Jataí', 'Maria de Fatima');
INSERT INTO Endereco VALUES ('0012T', '30120-744', 060,'Rua dos Carijós', 'Campo Grande', 'Monte Castelo');
INSERT INTO Endereco VALUES ('0013T', '79002-290', 90,'Rua da Imprensa', 'Campo Grande', 'Barris');
INSERT INTO Endereco VALUES ('0014T', '62011-140', 1516,'Rua Pedro Martins', 'Sobral', 'Centro');
INSERT INTO Endereco VALUES ('0015T', '66055-260', 16,'Rua Antonio Joaquim', 'Belém', 'Nazaré');
INSERT INTO Endereco VALUES ('0016T', '96204-040', 1220,'Rua Dr Xavier', 'Rio Grande', 'Zona Portuária');
INSERT INTO Endereco VALUES ('0017T', '16015-244', 30,'Rua Cristiano Olsen', 'Araçatuba', 'Jardim Sumaré');
INSERT INTO Endereco VALUES ('0018T', '71020-631', 035,'Rua dos Proprietários', 'Brasília', 'Guará I');
INSERT INTO Endereco VALUES ('0019T', '28035-042', 40,'Rua Trenzinho Feliz', 'Campo dos Goytacazes', 'Califórnia');
INSERT INTO Endereco VALUES ('0020T', '16015-244', 605,'Rua Esquenta Pandeiro', 'Melos', 'Jardim Sumaré');
commit;

begin;
INSERT INTO Transportadora VALUES('1000T', 'Patrus');
INSERT INTO Transportadora VALUES('1001T', 'Leva já');
INSERT INTO Transportadora VALUES('1002T', 'Expresso Mudanças');
INSERT INTO Transportadora VALUES('1003T', 'Entrega já');
INSERT INTO Transportadora VALUES('1004T', 'Correria');
INSERT INTO Transportadora VALUES('1005T', 'Vapt Vupt');
INSERT INTO Transportadora VALUES('1006T', 'Bate volta');
INSERT INTO Transportadora VALUES('1007T', 'Brasspress');
INSERT INTO Transportadora VALUES('1008T', 'TNT');
INSERT INTO Transportadora VALUES('1009T', 'Rodonaves');
INSERT INTO Transportadora VALUES('1010T', 'Jamef');
INSERT INTO Transportadora VALUES('1011T', 'Alfa ');
INSERT INTO Transportadora VALUES('1012T', 'Mudanças já');
INSERT INTO Transportadora VALUES('1013T', 'Frete bem');
INSERT INTO Transportadora VALUES('1014T', 'Correios');
INSERT INTO Transportadora VALUES('1015T', 'Giro Flex');
INSERT INTO Transportadora VALUES('1016T', 'Via Segura');
INSERT INTO Transportadora VALUES('1017T', 'Milhas Run');
INSERT INTO Transportadora VALUES('1018T', 'PapaLéguas');
INSERT INTO Transportadora VALUES('1019T', 'Lebre');
commit;

begin;
INSERT INTO Fornecedor VALUES('5001F', 'KLIN', '73 98587-2280');
INSERT INTO Fornecedor VALUES('5002F', 'MOSKINO', '21 2545-2788');
INSERT INTO Fornecedor VALUES('5003F', 'DIOR', '55 54875-4545');
INSERT INTO Fornecedor VALUES('5004F', 'PRADA', '88 98887-5744');
INSERT INTO Fornecedor VALUES('5005F', 'NIKE', '11 5547-2771');
INSERT INTO Fornecedor VALUES('5006F', 'ADIDAS', '11 4477-2778');
INSERT INTO Fornecedor VALUES('5007F', 'HOUSTON', '71 7887-0102');
INSERT INTO Fornecedor VALUES('5008F', 'DOLCE G', '21 2045-2040');
INSERT INTO Fornecedor VALUES('5009F', 'LUPO', '21 3478-2222');
INSERT INTO Fornecedor VALUES('5010F', 'CARTIER', '32 2574-8588');
INSERT INTO Fornecedor VALUES('5011F', 'GUCCI', '+1 2555-1141');
INSERT INTO Fornecedor VALUES('5012F', 'HURLEY', '77 7477-9911');
INSERT INTO Fornecedor VALUES('5013F', 'LACOSTE', '11 4121-7796');
INSERT INTO Fornecedor VALUES('5014F', 'APPLE', '44 7444-1145');
INSERT INTO Fornecedor VALUES('5015F', 'UMBRO', '21 3478-2222');
INSERT INTO Fornecedor VALUES('5016F', 'WILSON', '99 7847-2007');
INSERT INTO Fornecedor VALUES('5017F', 'MIZUNO', '65 4787-1287');
INSERT INTO Fornecedor VALUES('5018F', 'CALESITA', '21 1477-0000');
INSERT INTO Fornecedor VALUES('5019F', 'LEGO', '74 4589-2129');
INSERT INTO Fornecedor VALUES('5020F', 'COLCCI', '32 8747-7784');
commit;

begin;
INSERT INTO Empresa VALUES('65.514.402/0001-50', 'MJ Comercio', 'Adr almeida', '0001E' );
INSERT INTO Empresa VALUES('99.872.486/0001-15', 'Meire Kids', 'Vrf goes', '0002E' );
INSERT INTO Empresa VALUES('47.223.201/0001-11', 'Joaninha baby', 'JFK Confeccoes', '0003E' );
INSERT INTO Empresa VALUES('73.326.157/0001-85', 'Bike e Cia', 'Es. comercio', '0004E' );
INSERT INTO Empresa VALUES('61.238.728/0001-40', 'Importados e Cia', 'ISF morais', '0005E' );
INSERT INTO Empresa VALUES('52.322.514/0001-67', 'KAJU E KASTANHA COMERCIO', 'Cc andrade', '0006E');
INSERT INTO Empresa VALUES('29.423.887/0001-02', 'Emporio das marcas', 'adt novais', '0007E');
INSERT INTO Empresa VALUES('08.030.372/0001-72', 'Konverge em k', 'Al silva', '0008E');
INSERT INTO Empresa VALUES('55.212.126/0001-11', 'Max Importados', 'Jorge almeida ', '0009E');
INSERT INTO Empresa VALUES('45.744.852/0001-21', 'TEC-TOY Brinquedos', 'Ramos pereira', '0010E');
INSERT INTO Empresa VALUES('03.088.464/0001-90', 'Tomás e Nathan Entulhos Ltda', 'TeN Novais', '0011E');
INSERT INTO Empresa VALUES('25.179.555/0001-73', 'Bento e Clara Filmagens Ltda', 'Bent Silva Importados', '0012E');
INSERT INTO Empresa VALUES('13.387.820/0001-20', 'ATACADÃO PORTAL', 'RC comercio', '0013E');
INSERT INTO Empresa VALUES('65.773.941/0002-87', 'Importa e Vende', 'Matos moura', '0014E');
INSERT INTO Empresa VALUES('22.194.873/0001-78', 'Casas Americanas', 'Jorge borges c.', '0015E');
INSERT INTO Empresa VALUES('35.684.801/0002-14', 'Casa do 1.99', 'Lopes feitosa brinq', '0016E');
INSERT INTO Empresa VALUES('31.132.847/0001-73', 'Esporte & Cia', 'Melo & Souza', '0017E');
INSERT INTO Empresa VALUES('99.941.673/0001-92', 'Moveis Guaibim', 'Roger mota', '0018E');
INSERT INTO Empresa VALUES('87.964.798/0001-91', 'Regatas Topper', 'Aldo modas', '0019E');
INSERT INTO Empresa VALUES('18.975.444/0002-88', 'Pereira Multimarcas', 'Mondez e meio', '0020E');
commit;

begin;
INSERT INTO Comprador VALUES('0001CO' , 'Augusto Mateus');
INSERT INTO Comprador VALUES('0002CO' , 'Paulo Goes');
INSERT INTO Comprador VALUES('0003CO', 'Edson Martins');
INSERT INTO Comprador VALUES('0004CO', 'Marcelo Silva');
INSERT INTO Comprador VALUES('0005CO', 'Claudia mota');
INSERT INTO Comprador VALUES('0006CO', 'Beatriz Soares');
INSERT INTO Comprador VALUES('0007CO', 'Claudio Rocha');
INSERT INTO Comprador VALUES('0008CO', 'Danilo Gomes');
INSERT INTO Comprador VALUES('0009CO', 'Endriw Luka');
INSERT INTO Comprador VALUES('0010CO', 'Lucas Aguiar');
INSERT INTO Comprador VALUES('0011CO', 'Bruno Jesus');
INSERT INTO Comprador VALUES('0012CO', 'Fernanda Silva');
INSERT INTO Comprador VALUES('0013CO', 'Eduardo Silva');
INSERT INTO Comprador VALUES('0014CO', 'Gislene Freitas');
INSERT INTO Comprador VALUES('0015CO', 'Pedro Pedrão');
INSERT INTO Comprador VALUES('0016CO', 'Jonas Neres');
INSERT INTO Comprador VALUES('0017CO', 'Tarso Genro');
INSERT INTO Comprador VALUES('0018CO', 'Allan Sergio');
INSERT INTO Comprador VALUES('0019CO', 'Divan de Melo');
INSERT INTO Comprador VALUES('0020CO', 'Lucas Lopes');
commit;

begin;
INSERT INTO Funcionario VALUES('000FU', 'vendas', 'Valentina Shronder', NULL  );
INSERT INTO Funcionario VALUES('001FU', 'fiscal', 'Adriano Almeida', NULL  );
INSERT INTO Funcionario VALUES('002FU', 'financeiro', 'Jorge menezes', NULL  );
INSERT INTO Funcionario VALUES('003FU', 'vendas', 'Meeg rosa', NULL  );
INSERT INTO Funcionario VALUES('005FU', 'supervisor', 'Antonio Carlos', NULL  );
INSERT INTO Funcionario VALUES('006FU', 'comprador', 'Augusto Mateus', '0001CO'  );
INSERT INTO Funcionario VALUES('007FU', 'caixa', 'Léa correa', NULL  );
INSERT INTO Funcionario VALUES('008FU', 'logistica', 'Lucas Santos', NULL );
INSERT INTO Funcionario VALUES('009FU', 'financeiro', 'Eliane Rodrigues', NULL );
INSERT INTO Funcionario VALUES('010FU', 'comprador', 'Paulo Goes', '0002CO');
INSERT INTO Funcionario VALUES('011FU', 'comprador', 'Edson Martins', '0003CO' );
INSERT INTO Funcionario VALUES('012FU', 'caixa', 'Claudia Teles', NULL );
INSERT INTO Funcionario VALUES('013FU', 'comprador', 'Marcelo Silva', '0004CO' );
INSERT INTO Funcionario VALUES('014FU', 'comprador', 'Claudia Mota', '0005CO' );
INSERT INTO Funcionario VALUES('015FU', 'caixa', 'Orlando Silva', NULL );
INSERT INTO Funcionario VALUES('016FU', 'comprador', 'Beatriz Soares', '0006CO' );
INSERT INTO Funcionario VALUES('017FU', 'comprador', 'Claudio Rocha', '0007CO' );
INSERT INTO Funcionario VALUES('018FU', 'comprador', 'Danilo Gomes', '0008CO' );
INSERT INTO Funcionario VALUES('019FU', 'comprador', 'Endriw Luka', '0009CO' );
INSERT INTO Funcionario VALUES('020FU', 'comprador', 'Lucas Aguiar', '0010CO' );
INSERT INTO Funcionario VALUES('021FU', 'comprador', 'Bruno Jesus ', '0011CO' );
INSERT INTO Funcionario VALUES('022FU', 'comprador', 'Fernanda Silva', '0012CO' );
INSERT INTO Funcionario VALUES('023FU', 'comprador', 'Eduardo Silva ', '0013CO' );
INSERT INTO Funcionario VALUES('024FU', 'comprador', 'Gislene Freitas', '0014CO' );
INSERT INTO Funcionario VALUES('025FU', 'comprador', 'Pedro Pedrão ', '0015CO' );
INSERT INTO Funcionario VALUES('026FU', 'comprador', 'Jonas Neres ', '0016CO' );
INSERT INTO Funcionario VALUES('027FU', 'comprador', 'Tarso Genro ', '0017CO' );
INSERT INTO Funcionario VALUES('028FU', 'comprador', 'Allan Sergio', '0018CO' );
INSERT INTO Funcionario VALUES('029FU', 'comprador', 'Divan de Melo', '0019CO' );
INSERT INTO Funcionario VALUES('030FU', 'comprador', 'Lucas Lopes', '0020CO' );
commit;

begin;
INSERT INTO Pedido VALUES(9001, 2500);
INSERT INTO Pedido VALUES(9002, 5500);
INSERT INTO Pedido VALUES(9003, 2300);
INSERT INTO Pedido VALUES(9004, 9100);
INSERT INTO Pedido VALUES(9005, 6900);
INSERT INTO Pedido VALUES(9006, 1100);
INSERT INTO Pedido VALUES(9007, 500);
INSERT INTO Pedido VALUES(9008, 1590);
INSERT INTO Pedido VALUES(9009, 8080);
INSERT INTO Pedido VALUES(9010, 4585);
INSERT INTO Pedido VALUES(9011, 3333);
INSERT INTO Pedido VALUES(9012, 7720);
INSERT INTO Pedido VALUES(9013, 6500);
INSERT INTO Pedido VALUES(9014, 9320);
INSERT INTO Pedido VALUES(9015, 500);
INSERT INTO Pedido VALUES(9016, 4100);
INSERT INTO Pedido VALUES(9017, 195);
INSERT INTO Pedido VALUES(9018, 4500);
INSERT INTO Pedido VALUES(9019, 5120);
INSERT INTO Pedido VALUES(9020, 3245);
commit;


begin;
INSERT INTO NotaFiscal VALUES( 2587, 1850, '2021/01/21', 4, 7.5, '5003F', 9001);
INSERT INTO NotaFiscal VALUES( 2510, 5700, '2021/07/04', 3, NULL, '5001F', 9002);
INSERT INTO NotaFiscal VALUES( 15544, 7050 , '2021/05/01', NULL , 2.5, '5002F', 9003);
INSERT INTO NotaFiscal VALUES( 87, 1000, '2021/12/21', 2, 8.5, '5003F', 9004);
INSERT INTO NotaFiscal VALUES( 2477, 1850, '2021/01/21', 4, 7.5, '5004F', 9005);
INSERT INTO NotaFiscal VALUES( 3, 850, '2021/11/05', '2', NULL, '5001F', 9006);
INSERT INTO NotaFiscal VALUES( 2222, 6922, '2021/05/05', 7, 10.0, '5006F', 9007);
INSERT INTO NotaFiscal VALUES( 3531, 5000, '2021/05/01', 4, NULL, '5007F', 9008);
INSERT INTO NotaFiscal VALUES( 2500, 7100, '2021/12/03', 2, 5.0, '5002F', 9009);
INSERT INTO NotaFiscal VALUES( 10, 1050, '2021/12/12', 9, 9.5, '5009F', 9010);
INSERT INTO NotaFiscal VALUES( 5000, 500, '2021/03/03', 2, NULL, '5010F', 9011);
INSERT INTO NotaFiscal VALUES( 85, 520, '2015/02/21', 5, 1.5, '5012F', 9013);
INSERT INTO NotaFiscal VALUES( 86, 3566, '2015/02/22', 3, NULL, '5012F', 9013);
INSERT INTO NotaFiscal VALUES( 2223, 2166, '2022/05/10', 4, NULL, '5006F', 9007);
INSERT INTO NotaFiscal VALUES( 654, 599, '2013/12/22', 6, 1.5, '5012F', 9013);
INSERT INTO NotaFiscal VALUES( 861, 3566, '2011/12/22', 1, 2.5, '5015F', 9015);
INSERT INTO NotaFiscal VALUES( 47, 1187, '2012/02/22', 6, 5.4, '5018F', 9017);
INSERT INTO NotaFiscal VALUES( 8745, 8888, '2022/02/22', 7, NULL, '5005F', 9018);
INSERT INTO NotaFiscal VALUES( 1234, 1000, '2014/05/14', 2, 7.9, '5019F', 9019);
INSERT INTO NotaFiscal VALUES( 917, 507, '2014/05/14', 1, NULL, '5019F', 9019);
commit;



begin;
INSERT INTO Produto VALUES('7000P', 'Bolsa', 50, '01542910', 'Bolsa-estrela-flamejante-dior' );
INSERT INTO Produto VALUES('7001P', 'Relogio', 300, '25992050', 'Relogio-estilo-nike' );
INSERT INTO Produto VALUES('7002P', 'Cardigan', 120, '44543322', 'Cardin-preto-casual-dolce gabb' );
INSERT INTO Produto VALUES('7003P', 'Bola', 95, '771154410', 'Bola-adidas' );
INSERT INTO Produto VALUES('7004P', 'Gorro', 35, '19770311', 'Gorro-tendencia-unico-cartier' );
INSERT INTO Produto VALUES('7005P', 'Shoulder-bag', 55, '01542920', 'shoulder-estilo-hentai-dior' );
INSERT INTO Produto VALUES('7006P', 'Sapato Menino', 16, '15876497', 'sapatinho-molekinho' );
INSERT INTO Produto VALUES('7007P', 'Sapato Menina', 50, '15876497', 'sapatinho-molekinha' );
INSERT INTO Produto VALUES('7008P', 'Bolsa', 67, '01542910', 'Bolsa-prada-derico-moskino' );
INSERT INTO Produto VALUES('7009P', 'Meia', 9, '64819750', 'meia-antiderrapante-lupo' );
INSERT INTO Produto VALUES('7010P', 'Patinete', 450, '18763428', 'patinete-diversao-calesita' );
INSERT INTO Produto VALUES('7011P', 'Cross-turbo', 340, '74861789', 'velotró-calesita' );
INSERT INTO Produto VALUES('7012P', 'Boné', 50, '19770311', 'boné-hurley' );
INSERT INTO Produto VALUES('7013P', 'Chuteira', 199, '57198433', 'chuteira-mizuno-jogadorcaro' );
INSERT INTO Produto VALUES('7014P', 'Bola', 99, '77115410', 'bola-jogadormedio-wilson' );
INSERT INTO Produto VALUES('7015P', 'Celular', 5599, '76821147', 'Cel-Caro-Apple' );
INSERT INTO Produto VALUES('7016P', 'Calça', 595, '78477931', 'calça-colcci-patrao' );
INSERT INTO Produto VALUES('7017P', 'Bloco de montar', 145, '44771987', 'Bloco-lego' );
INSERT INTO Produto VALUES('7018P', 'Futsal', 189, '47975811', 'futsal-derrapa-umbro' );
INSERT INTO Produto VALUES('7019P', 'Carteira', 16, '47548712', 'Carteira-gucci' );
INSERT INTO Produto VALUES('7020P', 'Bicicleta', 899, '78459747', 'bike-radikal-houston' );
commit;

begin;
INSERT INTO PossuiEndTransp VALUES('0001T' , '1000T');
INSERT INTO PossuiEndTransp VALUES('0002T' , '1001T');
INSERT INTO PossuiEndTransp VALUES('0003T' , '1002T');
INSERT INTO PossuiEndTransp VALUES('0004T' , '1003T');
INSERT INTO PossuiEndTransp VALUES('0005T' , '1004T');
INSERT INTO PossuiEndTransp VALUES('0006T' , '1005T');
INSERT INTO PossuiEndTransp VALUES('0007T' , '1006T');
INSERT INTO PossuiEndTransp VALUES('0008T' , '1007T');
INSERT INTO PossuiEndTransp VALUES('0009T' , '1008T');
INSERT INTO PossuiEndTransp VALUES('0010T' , '1009T');
INSERT INTO PossuiEndTransp VALUES('0011T' , '1010T');
INSERT INTO PossuiEndTransp VALUES('0012T' , '1011T');
INSERT INTO PossuiEndTransp VALUES('0013T' , '1012T');
INSERT INTO PossuiEndTransp VALUES('0014T' , '1013T');
INSERT INTO PossuiEndTransp VALUES('0015T' , '1014T');
INSERT INTO PossuiEndTransp VALUES('0016T' , '1015T');
INSERT INTO PossuiEndTransp VALUES('0017T' , '1016T');
INSERT INTO PossuiEndTransp VALUES('0018T' , '1017T');
INSERT INTO PossuiEndTransp VALUES('0019T' , '1018T');
INSERT INTO PossuiEndTransp VALUES('0020T' , '1019T');
commit;

begin;
INSERT INTO EncaminhaTranspNota VALUES ('1001T', 2587, '2022/06/19', '2022/07/05' );
INSERT INTO EncaminhaTranspNota VALUES ('1001T', 2510, '2022/06/19', '2022/07/05' );
INSERT INTO EncaminhaTranspNota VALUES ('1005T', 15544, '2015/06/14', '2015/07/25' );
INSERT INTO EncaminhaTranspNota VALUES ('1004T', 87, '2020/03/13', '2020/03/14' );
INSERT INTO EncaminhaTranspNota VALUES ('1010T', 2477, '2015/06/15', '2015/07/05' );
INSERT INTO EncaminhaTranspNota VALUES ('1010T', 3, '2015/06/15', '2015/07/07' );
INSERT INTO EncaminhaTranspNota VALUES ('1010T', 2222, '2001/04/16', '2002/11/04' );
INSERT INTO EncaminhaTranspNota VALUES ('1015T', 3531, '2011/01/19', '2011/02/13' );
INSERT INTO EncaminhaTranspNota VALUES ('1003T', 2500, '2022/06/05', '2022/07/05' );
INSERT INTO EncaminhaTranspNota VALUES ('1004T', 10, '1997/05/11', '1999/01/09' );
INSERT INTO EncaminhaTranspNota VALUES ('1004T', 5000, '2012/06/11', '2013/04/01' );
INSERT INTO EncaminhaTranspNota VALUES ('1011T', 85, '2022/06/01', '2022/06/01' );
INSERT INTO EncaminhaTranspNota VALUES ('1011T', 86, '2022/06/02', '2022/06/03' );
INSERT INTO EncaminhaTranspNota VALUES ('1014T', 2223, '2007/06/11', '2008/11/14' );
INSERT INTO EncaminhaTranspNota VALUES ('1019T', 654, '2022/04/17', '2022/07/19' );
INSERT INTO EncaminhaTranspNota VALUES ('1019T', 86, '2021/12/10', '2021/12/31' );
INSERT INTO EncaminhaTranspNota VALUES ('1018T', 47, '2017/06/19', '2018/08/05' );
INSERT INTO EncaminhaTranspNota VALUES ('1009T', 8745, '2022/07/14', '2022/08/14' );
INSERT INTO EncaminhaTranspNota VALUES ('1009T', 1234, '2019/03/31', '2019/04/14' );
INSERT INTO EncaminhaTranspNota VALUES ('1015T', 917, '2022/01/01', '2022/07/10' );
commit;

begin;
INSERT INTO PossuiEndFornecedor VALUES('0001F', '5001F');
INSERT INTO PossuiEndFornecedor VALUES('0002F', '5002F');
INSERT INTO PossuiEndFornecedor VALUES('0003F', '5003F');
INSERT INTO PossuiEndFornecedor VALUES('0004F', '5004F');
INSERT INTO PossuiEndFornecedor VALUES('0005F', '5005F');
INSERT INTO PossuiEndFornecedor VALUES('0006F', '5006F');
INSERT INTO PossuiEndFornecedor VALUES('0007F', '5007F');
INSERT INTO PossuiEndFornecedor VALUES('0008F', '5008F');
INSERT INTO PossuiEndFornecedor VALUES('0009F', '5009F');
INSERT INTO PossuiEndFornecedor VALUES('0010F', '5010F');
INSERT INTO PossuiEndFornecedor VALUES('0011F', '5011F');
INSERT INTO PossuiEndFornecedor VALUES('0012F', '5012F');
INSERT INTO PossuiEndFornecedor VALUES('0013F', '5013F');
INSERT INTO PossuiEndFornecedor VALUES('0014F', '5014F');
INSERT INTO PossuiEndFornecedor VALUES('0015F', '5015F');
INSERT INTO PossuiEndFornecedor VALUES('0016F', '5016F');
INSERT INTO PossuiEndFornecedor VALUES('0017F', '5017F');
INSERT INTO PossuiEndFornecedor VALUES('0018F', '5018F');
INSERT INTO PossuiEndFornecedor VALUES('0019F', '5019F');
INSERT INTO PossuiEndFornecedor VALUES('0020F', '5020F');

commit;

begin;
INSERT INTO RotaEndNota VALUES ('0001E', 2587);
INSERT INTO RotaEndNota VALUES ('0002E', 2510);
INSERT INTO RotaEndNota VALUES ('0003E', 15544);
INSERT INTO RotaEndNota VALUES ('0004E', 87);
INSERT INTO RotaEndNota VALUES ('0005E', 2477);
INSERT INTO RotaEndNota VALUES ('0006E', 3);
INSERT INTO RotaEndNota VALUES ('0007E', 2222);
INSERT INTO RotaEndNota VALUES ('0008E', 3531);
INSERT INTO RotaEndNota VALUES ('0009E', 2500);
INSERT INTO RotaEndNota VALUES ('0010E', 10);
INSERT INTO RotaEndNota VALUES ('0011E', 5000);
INSERT INTO RotaEndNota VALUES ('0012E', 85);
INSERT INTO RotaEndNota VALUES ('0013E', 86);
INSERT INTO RotaEndNota VALUES ('0014E', 2223);
INSERT INTO RotaEndNota VALUES ('0015E', 654);
INSERT INTO RotaEndNota VALUES ('0016E', 861);
INSERT INTO RotaEndNota VALUES ('0017E', 47);
INSERT INTO RotaEndNota VALUES ('0018E', 8745);
INSERT INTO RotaEndNota VALUES ('0019E', 1234);
INSERT INTO RotaEndNota VALUES ('0020E', 917);
commit;

begin;
INSERT INTO PossuiFuncEmpresa VALUES ('000FU', '47.223.201/0001-11' );
INSERT INTO PossuiFuncEmpresa VALUES ('001FU', '47.223.201/0001-11' );
INSERT INTO PossuiFuncEmpresa VALUES ('002FU', '65.514.402/0001-50' );
INSERT INTO PossuiFuncEmpresa VALUES ('003FU', '99.872.486/0001-15' );
INSERT INTO PossuiFuncEmpresa VALUES ('005FU', '65.514.402/0001-50' );
INSERT INTO PossuiFuncEmpresa VALUES ('006FU', '47.223.201/0001-11' );
INSERT INTO PossuiFuncEmpresa VALUES ('007FU', '25.179.555/0001-73' );
INSERT INTO PossuiFuncEmpresa VALUES ('008FU', '55.212.126/0001-11' );
INSERT INTO PossuiFuncEmpresa VALUES ('009FU', '99.941.673/0001-92' );
INSERT INTO PossuiFuncEmpresa VALUES ('010FU', '73.326.157/0001-85' );
INSERT INTO PossuiFuncEmpresa VALUES ('011FU', '99.941.673/0001-92' );
INSERT INTO PossuiFuncEmpresa VALUES ('012FU', '35.684.801/0002-14' );
INSERT INTO PossuiFuncEmpresa VALUES ('013FU', '18.975.444/0002-88' );
INSERT INTO PossuiFuncEmpresa VALUES ('014FU', '08.030.372/0001-72' );
INSERT INTO PossuiFuncEmpresa VALUES ('015FU', '18.975.444/0002-88' );
INSERT INTO PossuiFuncEmpresa VALUES ('016FU', '45.744.852/0001-21' );
INSERT INTO PossuiFuncEmpresa VALUES ('017FU', '13.387.820/0001-20' );
INSERT INTO PossuiFuncEmpresa VALUES ('018FU', '13.387.820/0001-20' );
INSERT INTO PossuiFuncEmpresa VALUES ('019FU', '99.872.486/0001-15' );
INSERT INTO PossuiFuncEmpresa VALUES ('020FU', '61.238.728/0001-40' );
INSERT INTO PossuiFuncEmpresa VALUES ('021FU', '52.322.514/0001-67' );
INSERT INTO PossuiFuncEmpresa VALUES ('022FU', '29.423.887/0001-02' );
INSERT INTO PossuiFuncEmpresa VALUES ('023FU', '03.088.464/0001-90' );
INSERT INTO PossuiFuncEmpresa VALUES ('024FU', '65.773.941/0002-87' );
INSERT INTO PossuiFuncEmpresa VALUES ('025FU', '31.132.847/0001-73' );
INSERT INTO PossuiFuncEmpresa VALUES ('026FU', '87.964.798/0001-91' );
INSERT INTO PossuiFuncEmpresa VALUES ('027FU', '87.964.798/0001-91' );
INSERT INTO PossuiFuncEmpresa VALUES ('028FU', '22.194.873/0001-78' );
INSERT INTO PossuiFuncEmpresa VALUES ('029FU', '22.194.873/0001-78' );
INSERT INTO PossuiFuncEmpresa VALUES ('030FU', '35.684.801/0002-14' );
commit;

begin;
INSERT INTO RealizaPedidoComprador VALUES (9001, '0001CO', '2022/05/21');
INSERT INTO RealizaPedidoComprador VALUES (9002, '0002CO', '2022/07/22');
INSERT INTO RealizaPedidoComprador VALUES (9003, '0003CO', '2021/12/05');
INSERT INTO RealizaPedidoComprador VALUES (9004, '0004CO', '2022/06/01');
INSERT INTO RealizaPedidoComprador VALUES (9005, '0005CO', '2019/02/25');
INSERT INTO RealizaPedidoComprador VALUES (9006, '0006CO', '2020/12/14');
INSERT INTO RealizaPedidoComprador VALUES (9007, '0007CO', '2015/08/01');
INSERT INTO RealizaPedidoComprador VALUES (9008, '0008CO', '2016/07/03');
INSERT INTO RealizaPedidoComprador VALUES (9009, '0009CO', '1997/04/21');
INSERT INTO RealizaPedidoComprador VALUES (9010, '0010CO', '2020/10/21');
INSERT INTO RealizaPedidoComprador VALUES (9011, '0011CO', '2009/03/19');
INSERT INTO RealizaPedidoComprador VALUES (9012, '0012CO', '2022/04/29');
INSERT INTO RealizaPedidoComprador VALUES (9013, '0013CO', '2017/11/30');
INSERT INTO RealizaPedidoComprador VALUES (9014, '0014CO', '2021/03/22');
INSERT INTO RealizaPedidoComprador VALUES (9015, '0015CO', '2004/12/14');
INSERT INTO RealizaPedidoComprador VALUES (9016, '0016CO', '2009/04/02');
INSERT INTO RealizaPedidoComprador VALUES (9017, '0017CO', '2017/04/25');
INSERT INTO RealizaPedidoComprador VALUES (9018, '0018CO', '2018/05/14');
INSERT INTO RealizaPedidoComprador VALUES (9019, '0019CO', '2021/05/26');
INSERT INTO RealizaPedidoComprador VALUES (9020, '0020CO', '1997/01/26');
commit;

begin;
INSERT INTO ConteudoProdutoPedido VALUES ('7000P', 9001, 22); 
INSERT INTO ConteudoProdutoPedido VALUES ('7001P', 9002, 27); 
INSERT INTO ConteudoProdutoPedido VALUES ('7002P', 9003, 32); 
INSERT INTO ConteudoProdutoPedido VALUES ('7003P', 9004, 75); 
INSERT INTO ConteudoProdutoPedido VALUES ('7004P', 9005, 84); 
INSERT INTO ConteudoProdutoPedido VALUES ('7005P', 9006, 93); 
INSERT INTO ConteudoProdutoPedido VALUES ('7006P', 9007, 52); 
INSERT INTO ConteudoProdutoPedido VALUES ('7007P', 9008, 134); 
INSERT INTO ConteudoProdutoPedido VALUES ('7008P', 9009, 132); 
INSERT INTO ConteudoProdutoPedido VALUES ('7009P', 9010, 123); 
INSERT INTO ConteudoProdutoPedido VALUES ('7010P', 9011, 321); 
INSERT INTO ConteudoProdutoPedido VALUES ('7011P', 9012, 147); 
INSERT INTO ConteudoProdutoPedido VALUES ('7012P', 9013, 258); 
INSERT INTO ConteudoProdutoPedido VALUES ('7013P', 9014, 74); 
INSERT INTO ConteudoProdutoPedido VALUES ('7014P', 9015, 77); 
INSERT INTO ConteudoProdutoPedido VALUES ('7015P', 9016, 88); 
INSERT INTO ConteudoProdutoPedido VALUES ('7016P', 9017, 98); 
INSERT INTO ConteudoProdutoPedido VALUES ('7017P', 9018, 66); 
INSERT INTO ConteudoProdutoPedido VALUES ('7018P', 9019, 62); 
INSERT INTO ConteudoProdutoPedido VALUES ('7019P', 9020, 24); 
commit;