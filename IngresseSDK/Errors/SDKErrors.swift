//
//  Copyright © 2016 Ingresse. All rights reserved.
//

import UIKit

public class SDKErrors: NSObject {
    static let shared = SDKErrors()

    let errors = [
        -1: "Verifique suas informações e tente novamente.",
        56: "Senha atual incorreta.",
        1033: "Verifique se preencheu o campo de CPF e tente novamente.",
        1061: "Acesse a área de \"Meus Dados\" por um navegador desktop ou mobile e preencha as informações que faltam.",
        1109: "Este telefone já foi utilizado para validar uma conta Ingresse. Insira outro número ou entre em contato com nosso suporte.",
        2006: "Por favor, refaça a operação de login e tente novamente. Caso o erro persista, atualize o aplicativo.",
        2012: "Verifique em seu aparelho se as configurações de data e hora estão em \"ajuste automático\" e tente novamente.",
        3027: "Por favor, refaça a operação de login e tente novamente.",
        3041: "Lamentamos, mas os ingressos para este setor esgotaram. Selecione outro tipo de ingresso e tente novamente.",
        5010: "Tente realizar a compra em um computador ou entre em contato com nosso suporte.",
        6001: "A venda deste evento não está ativada. Entre em contato com o organizador do evento.",
        6002: "Todas as sessões para esse evento estão esgotadas. Talvez alguns ingressos estarão disponíveis dependendo dos pagamentos pendentes. Entre em contato com o organizador do evento.",
        6003: "Não há mais ingressos disponíveis para venda. Talvez alguns ingressos estarão disponíveis dependendo dos pagamentos pendentes. Entre em contato com o organizador do evento.",
        6004: "Não há mais ingressos disponíveis para um dos tipos de ingressos selecionados. Entre em contato com o organizador do evento.",
        6005: "A transação que está tentando pagar não está mais disponível. Por favor, tente novamente.",
        6006: "A quantidade de ingressos disponíveis é menor que a de solicitados.",
        6007: "Eventos blogger não possuem venda de ingressos.",
        6008: "Ingresso não encontrado na sessão.",
        6009: "O método de pagamento e/ou parcelamento não são aceitos para este evento.",
        6010: "Boleto não é aceito neste evento.",
        6011: "Boleto não pago.",
        6012: "Por favor, visite o site da Ingresse (ingresse.com) para comprar ingressos para esse evento.",
        6013: "Lamentamos, mas os ingressos para este setor esgotaram. Selecione outro tipo de ingresso e tente novamente.",
        6014: "Você excedeu o limite de ingressos disponíveis por conta. Para mais informações, verifique a descrição do evento.",
        6034: "Ticket não está pendente. Verifique se a transferência foi cancelada.",
        6038: "Este ingresso já foi transferido. Atualize a sua carteira e verá para quem foi enviado o ingresso.",
        6039: "Este ingresso foi reembolsado. Atualize a sua carteira para ver somente os ingressos disponíveis.",
        6040: "Você já transferiu esse ingresso para um amigo.",
        6041: "A transferência de ingressos não está disponível para este evento.",
        6042: "Verifique o endereço de e-mail inserido e tente novamente.",
        6044: "Você excedeu o limite de ingressos disponíveis por conta. Para mais informações, verifique a descrição do evento.",
        6045: "Não é possível transferir um ingresso para a conta que realizou a compra.",
        6052: "Para comprar ingressos você precisa possuir uma conta Ingresse. Acesse ingresse.com e cadastre-se."]

    let titles = [
        -1: "Login incorreto",
        1033: "CPF obrigatório",
        1061: "Cadastro incompleto",
        1109: "Erro ao validar conta",
        2006: "Ops! Algo deu errado",
        2012: "Sessão expirada",
        3027: "Evento não encontrado",
        3041: "Ingresso indisponível",
        5010: "Ops! Algo deu errado",
        6013: "Ingresso indisponível",
        6038: "Ingresso já transferido",
        6042: "E-mail inválido",
        6045: "O ingresso já é seu",
        6052: "Login inexistente"]

    let errorDict = [
        "default_title": "Ops!",
        "default_message": "Ocorreu um problema e não conseguimos seguir em frente. Procure nosso suporte em contato@ingresse.com e informe o código ao lado. (%ld)",
        "default_no_code": "Ocorreu um problema e não conseguimos seguir em frente. Procure nosso suporte em contato@ingresse.com."]
    
    public func getErrorMessage(code: Int) -> String {
        if code == 0 {
            return errorDict["default_no_code"]!
        }
        
        guard let error = errors[code] else {
            return String(format: errorDict["default_message"]!, arguments: [code])
        }
        
        return error
    }

    public func getErrorTitle(code: Int) -> String {
        guard let title = titles[code] else {
            return errorDict["default_title"]!
        }

        return title
    }
}
