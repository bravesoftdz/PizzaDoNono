-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pizzanono
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzanono
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzanono` DEFAULT CHARACTER SET utf8 ;
USE `pizzanono` ;

-- -----------------------------------------------------
-- Table `pizzanono`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(55) NOT NULL,
  `dataNascimento` VARCHAR(10) NULL,
  `telefone` VARCHAR(13) NULL,
  `celular` VARCHAR(14) NULL,
  `tipoPessoa` TINYINT(1) NOT NULL COMMENT '1=pessoa fisica\n0=pessoa juridica\n',
  `cpfcnpj` VARCHAR(20) NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`tamanho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`tamanho` (
  `idtamanho` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `maxSabores` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtamanho`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`sabor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`sabor` (
  `idsabor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `valor` FLOAT NOT NULL,
  `tamanho_idtamanho` INT NOT NULL,
  PRIMARY KEY (`idsabor`),
  INDEX `fk_sabor_tamanho1_idx` (`tamanho_idtamanho` ASC),
  CONSTRAINT `fk_sabor_tamanho1`
    FOREIGN KEY (`tamanho_idtamanho`)
    REFERENCES `pizzanono`.`tamanho` (`idtamanho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`produto` (
  `idproduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `temSabor` TINYINT(1) NOT NULL,
  `preco` FLOAT NULL,
  PRIMARY KEY (`idproduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`estado` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `UF` VARCHAR(10) NULL,
  PRIMARY KEY (`idestado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`municipio` (
  `idmunicipio` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `estado_idestado` INT NOT NULL,
  PRIMARY KEY (`idmunicipio`),
  INDEX `fk_municipio_estado1_idx` (`estado_idestado` ASC),
  CONSTRAINT `fk_municipio_estado1`
    FOREIGN KEY (`estado_idestado`)
    REFERENCES `pizzanono`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`bairro` (
  `idbairro` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `municipio_idmunicipio` INT NOT NULL,
  PRIMARY KEY (`idbairro`),
  INDEX `fk_bairro_municipio1_idx` (`municipio_idmunicipio` ASC),
  CONSTRAINT `fk_bairro_municipio1`
    FOREIGN KEY (`municipio_idmunicipio`)
    REFERENCES `pizzanono`.`municipio` (`idmunicipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  `bairro_idbairro` INT NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `enderecoPrincipal` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_bairro1_idx` (`bairro_idbairro` ASC),
  INDEX `fk_endereco_cliente1_idx` (`cliente_idcliente` ASC),
  CONSTRAINT `fk_endereco_bairro1`
    FOREIGN KEY (`bairro_idbairro`)
    REFERENCES `pizzanono`.`bairro` (`idbairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `pizzanono`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `endereco_idendereco` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `hora` TIME NOT NULL COMMENT 'hora prevista para entrega',
  `solicitante` VARCHAR(45) NOT NULL COMMENT 'nome da pessoa que ligou\n',
  `atendente` VARCHAR(45) NOT NULL COMMENT 'pessoa que fez o pedido(nao necessariamente a que digitou)',
  `observações` VARCHAR(45) NOT NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_idcliente` ASC),
  INDEX `fk_pedido_usuario1_idx` (`usuario_idusuario` ASC),
  INDEX `fk_pedido_endereco1_idx` (`endereco_idendereco` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `pizzanono`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `pizzanono`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_endereco1`
    FOREIGN KEY (`endereco_idendereco`)
    REFERENCES `pizzanono`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`itemPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`itemPedido` (
  `pedido_idpedido` INT NOT NULL AUTO_INCREMENT,
  `produto_idproduto` INT NOT NULL,
  `valorUnitario` FLOAT NOT NULL,
  `ID` INT NOT NULL,
  `SequenciaItem` INT NOT NULL,
  INDEX `fk_pedido_has_produto_produto1_idx` (`produto_idproduto` ASC),
  INDEX `fk_pedido_has_produto_pedido1_idx` (`pedido_idpedido` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idx_PedidoSequencia` (`pedido_idpedido` ASC, `SequenciaItem` ASC),
  CONSTRAINT `fk_pedido_has_produto_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `pizzanono`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_produto_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `pizzanono`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`SaboresItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`SaboresItem` (
  `itemPedido_ID` INT NOT NULL AUTO_INCREMENT,
  `sabor_idsabor` INT NOT NULL,
  `ID` INT NOT NULL,
  INDEX `fk_SaboresItem_itemPedido1_idx` (`itemPedido_ID` ASC),
  INDEX `fk_SaboresItem_sabor1_idx` (`sabor_idsabor` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `IDX_UNICO` (`sabor_idsabor` ASC, `itemPedido_ID` ASC),
  CONSTRAINT `fk_SaboresItem_itemPedido1`
    FOREIGN KEY (`itemPedido_ID`)
    REFERENCES `pizzanono`.`itemPedido` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaboresItem_sabor1`
    FOREIGN KEY (`sabor_idsabor`)
    REFERENCES `pizzanono`.`sabor` (`idsabor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`SaboresDisponiveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`SaboresDisponiveis` (
  `produto_idproduto` INT NOT NULL,
  `sabor_idsabor` INT NOT NULL,
  `ID` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_SaboresPermitidos_produto1_idx` (`produto_idproduto` ASC),
  INDEX `fk_SaboresPermitidos_sabor1_idx` (`sabor_idsabor` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idx_unico` (`produto_idproduto` ASC, `sabor_idsabor` ASC),
  CONSTRAINT `fk_SaboresPermitidos_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `pizzanono`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaboresPermitidos_sabor1`
    FOREIGN KEY (`sabor_idsabor`)
    REFERENCES `pizzanono`.`sabor` (`idsabor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`ingrediente` (
  `idingrediente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idingrediente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzanono`.`sabor_ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzanono`.`sabor_ingrediente` (
  `sabor_idsabor` INT NOT NULL,
  `ingrediente_idingrediente` INT NOT NULL,
  PRIMARY KEY (`sabor_idsabor`, `ingrediente_idingrediente`),
  INDEX `fk_sabor_has_ingrediente_ingrediente1_idx` (`ingrediente_idingrediente` ASC),
  INDEX `fk_sabor_has_ingrediente_sabor1_idx` (`sabor_idsabor` ASC),
  CONSTRAINT `fk_sabor_has_ingrediente_sabor1`
    FOREIGN KEY (`sabor_idsabor`)
    REFERENCES `pizzanono`.`sabor` (`idsabor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sabor_has_ingrediente_ingrediente1`
    FOREIGN KEY (`ingrediente_idingrediente`)
    REFERENCES `pizzanono`.`ingrediente` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
