-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pizzaNono
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzaNono
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzaNono` DEFAULT CHARACTER SET utf8 ;
USE `pizzaNono` ;

-- -----------------------------------------------------
-- Table `pizzaNono`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`estado` (
  `idestado` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `UF` VARCHAR(2) NULL,
  PRIMARY KEY (`idestado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`municipio` (
  `idmunicipio` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `estado_idestado` INT NOT NULL,
  PRIMARY KEY (`idmunicipio`),
  INDEX `fk_municipio_estado1_idx` (`estado_idestado` ASC),
  CONSTRAINT `fk_municipio_estado1`
    FOREIGN KEY (`estado_idestado`)
    REFERENCES `pizzaNono`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`bairro` (
  `idbairro` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `municipio_idmunicipio` INT NOT NULL,
  PRIMARY KEY (`idbairro`),
  INDEX `fk_bairro_municipio1_idx` (`municipio_idmunicipio` ASC),
  CONSTRAINT `fk_bairro_municipio1`
    FOREIGN KEY (`municipio_idmunicipio`)
    REFERENCES `pizzaNono`.`municipio` (`idmunicipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`cliente` (
  `idcliente` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `cpf_cnpj` VARCHAR(45) NULL COMMENT 'nap deve ser obrigatorio',
  `telefone` VARCHAR(45) NULL COMMENT 'celular OU telefone OBRIGATPRIOS',
  `celular` VARCHAR(45) NULL COMMENT 'celular OU telefone OBRIGATPRIOS',
  `rua` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `bairro_idbairro` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_bairro1_idx` (`bairro_idbairro` ASC),
  CONSTRAINT `fk_cliente_bairro1`
    FOREIGN KEY (`bairro_idbairro`)
    REFERENCES `pizzaNono`.`bairro` (`idbairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`tamanho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`tamanho` (
  `idtamanho` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `maxSabores` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtamanho`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`sabor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`sabor` (
  `idsabor` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `ingredientes` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsabor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`preco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`preco` (
  `idpreco` INT NOT NULL,
  `valor` VARCHAR(45) NOT NULL,
  `sabor_idsabor` INT NOT NULL,
  `tamanho_idtamanho` INT NOT NULL,
  PRIMARY KEY (`idpreco`),
  INDEX `fk_preco_sabor_idx` (`sabor_idsabor` ASC),
  INDEX `fk_preco_tamanho1_idx` (`tamanho_idtamanho` ASC),
  CONSTRAINT `fk_preco_sabor`
    FOREIGN KEY (`sabor_idsabor`)
    REFERENCES `pizzaNono`.`sabor` (`idsabor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preco_tamanho1`
    FOREIGN KEY (`tamanho_idtamanho`)
    REFERENCES `pizzaNono`.`tamanho` (`idtamanho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`produto` (
  `idproduto` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `temSabor` TINYINT(1) NOT NULL,
  `preco` FLOAT NULL,
  PRIMARY KEY (`idproduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`usuario` (
  `idusuario` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`pedido` (
  `idpedido` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `hora` TIME NOT NULL COMMENT 'hora prevista para entrega',
  `solicitante` VARCHAR(45) NOT NULL COMMENT 'nome da pessoa que ligou\n',
  `atendente` VARCHAR(45) NOT NULL COMMENT 'pessoa que fez o pedido(nao necessariamente a que digitou)',
  `observações` VARCHAR(45) NOT NULL,
  `total` FLOAT NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `bairro_idbairro` INT NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_idcliente` ASC),
  INDEX `fk_pedido_usuario1_idx` (`usuario_idusuario` ASC),
  INDEX `fk_pedido_bairro1_idx` (`bairro_idbairro` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `pizzaNono`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `pizzaNono`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_bairro1`
    FOREIGN KEY (`bairro_idbairro`)
    REFERENCES `pizzaNono`.`bairro` (`idbairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`itemPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`itemPedido` (
  `pedido_idpedido` INT NOT NULL,
  `produto_idproduto` INT NOT NULL,
  `tamanho_idtamanho` INT NOT NULL,
  `valorUnitario` FLOAT NOT NULL,
  `ID` INT NOT NULL,
  `SequenciaItem` INT NOT NULL,
  INDEX `fk_pedido_has_produto_produto1_idx` (`produto_idproduto` ASC),
  INDEX `fk_pedido_has_produto_pedido1_idx` (`pedido_idpedido` ASC),
  INDEX `fk_pedidoProduto_tamanho1_idx` (`tamanho_idtamanho` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idx_PedidoSequencia` (`pedido_idpedido` ASC, `SequenciaItem` ASC),
  CONSTRAINT `fk_pedido_has_produto_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `pizzaNono`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_produto_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `pizzaNono`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidoProduto_tamanho1`
    FOREIGN KEY (`tamanho_idtamanho`)
    REFERENCES `pizzaNono`.`tamanho` (`idtamanho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`SaboresItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`SaboresItem` (
  `itemPedido_ID` INT NOT NULL,
  `sabor_idsabor` INT NOT NULL,
  `ID` INT NOT NULL,
  INDEX `fk_SaboresItem_itemPedido1_idx` (`itemPedido_ID` ASC),
  INDEX `fk_SaboresItem_sabor1_idx` (`sabor_idsabor` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `IDX_UNICO` (`sabor_idsabor` ASC, `itemPedido_ID` ASC),
  CONSTRAINT `fk_SaboresItem_itemPedido1`
    FOREIGN KEY (`itemPedido_ID`)
    REFERENCES `pizzaNono`.`itemPedido` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaboresItem_sabor1`
    FOREIGN KEY (`sabor_idsabor`)
    REFERENCES `pizzaNono`.`sabor` (`idsabor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaNono`.`SaboresPermitidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaNono`.`SaboresPermitidos` (
  `produto_idproduto` INT NOT NULL,
  `sabor_idsabor` INT NOT NULL,
  `ID` INT NOT NULL,
  INDEX `fk_SaboresPermitidos_produto1_idx` (`produto_idproduto` ASC),
  INDEX `fk_SaboresPermitidos_sabor1_idx` (`sabor_idsabor` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idx_unico` (`produto_idproduto` ASC, `sabor_idsabor` ASC),
  CONSTRAINT `fk_SaboresPermitidos_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `pizzaNono`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaboresPermitidos_sabor1`
    FOREIGN KEY (`sabor_idsabor`)
    REFERENCES `pizzaNono`.`sabor` (`idsabor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
