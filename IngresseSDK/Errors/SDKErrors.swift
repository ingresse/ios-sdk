//
//  Copyright © 2016 Ingresse. All rights reserved.
//

import UIKit

public class SDKErrors: NSObject {
    static let shared = SDKErrors()

    let httpStatusErrors = [
        401: "Acesso não autorizado. Verifique suas credenciais e tente novamente.",
        429: "Número muito alto de requisições, aguarde um momento e tente novamente"]

    let errors = [
        -1: "Verifique suas informações e tente novamente.",
        56: "Senha atual incorreta.",
        1033: "Verifique se preencheu o campo de CPF e tente novamente.",
        1060: "Por favor, verifique se você digitou um CPF válido.",
        1061: "Acesse a área de \"Meus Dados\" por um navegador desktop ou mobile e preencha as informações que faltam.",
        1109: "Este telefone já foi utilizado para criar ou validar uma conta Ingresse. Insira outro telefone ou entre em contato com nosso suporte pela opção ajuda.",
        1192: "Este número de telefone já está ativo em outra conta.",
        1139: "O campo EMAIL é necessário.",
        1141: "O campo SENHA é necessário.",
        1142: "O campo EMAIL é inválido.",
        1143: "O campo NOME é necessário.",
        1145: "O campo TELEFONE é necessário.",
        1144: "A senha deve conter 8 caracteres e ao menos uma letra.",
        1146: "O campo TELEFONE é inválido.",
        2006: "Por favor, refaça a operação de login e tente novamente. Caso o erro persista, atualize o aplicativo.",
        2012: "Verifique em seu aparelho se as configurações de data e hora estão em \"ajuste automático\" e tente novamente.",
        3027: "Por favor, refaça a operação de login e tente novamente.",
        3041: "Lamentamos, mas os ingressos para este setor esgotaram. Selecione outro tipo de ingresso e tente novamente.",
        5010: "Tente realizar a compra em um computador ou entre em contato com nosso suporte.",
        5012: "A utilização desse cartão não foi autorizada pela adquirente.",
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
        6031: "É necessário que você escolha o destino de cada um dos ingressos.",
        6034: "Ticket não está pendente. Verifique se a transferência foi cancelada.",
        6038: "Este ingresso já foi transferido. Atualize a sua carteira e verá para quem foi enviado o ingresso.",
        6039: "Este ingresso foi reembolsado. Atualize a sua carteira para ver somente os ingressos disponíveis.",
        6040: "Você já transferiu esse ingresso para um amigo.",
        6041: "A transferência de ingressos não está disponível para este evento.",
        6042: "Verifique o endereço de e-mail inserido e tente novamente.",
        6044: "Você excedeu o limite de ingressos disponíveis por conta. Para mais informações, verifique a descrição do evento.",
        6045: "Não é possível transferir um ingresso para a conta que realizou a compra.",
        6052: "Para comprar ingressos você precisa possuir uma conta Ingresse. Acesse ingresse.com e cadastre-se.",
        6062: "O token fornecido é inválido. Procure nosso suporte em contato@ingresse.com e informe o ocorrido.",
        6063: "Esse email já está em uso.",
        6065: "O token fornecido está expirado. Procure nosso suporte em contato@ingresse.com e informe o ocorrido.",
        6073: "Você só pode adicionar 3 cartões na sua conta. Se quer adicionar outro cartão é necessário excluir qualquer um dos outros que já estão cadastrados.",
        6074: "Cartão já cadastrado. Verifique seus cartões salvos."]

    let titles = [
        -1: "Login incorreto",
        1033: "CPF obrigatório",
        1060: "CPF inválido",
        1061: "CPF inválido",
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
        "default_no_code": "Ocorreu um problema e não conseguimos seguir em frente. Procure nosso suporte em contato@ingresse.com.",
        "default_gtw_message": "Não foi possível prosseguir com esta operação. Tente utilizar outro cartão como forma de pagamento.",
        "default_cpn_message": "Cupom inválido. Não foi possível aplicar este cupom a sua compra."
    ]

    let detailsErrorDict = [
        "CPN-11021": "Cupom inválido. Verifique se digitou corretamente.",
        "CPN-11005": "Código não enviado, tente novamente.",
        "CPN-11009": "Este cupom não pode ser aplicado a uma transação sem valor.",
        "CPN-11020": "Esta transação já possui um cupom aplicado.",
        "CPN-11022": "Cupom inválido, o desconto não poder ser maior que o valor da transação.",
        "CPN-11027": "Esse cupom atingiu a quantidade máxima de utilização.",
        "CPN-11025": "Este cupom ainda não está liberado para utilização.",
        "CPN-11026": "O período de validade deste cupom terminou.",
        "GTW-1001": "Bandeira do cartão não aceita",
        "GTW-1002": "Código de verificação incorreto",
        "GTW-1003": "Pagamento não autorizado",
        "GTW-1004": "Cartão inválido",
        "GTW-1005": "Número do cartão inválido",
        "GTW-1006": "Cartão de crédito expirado",
        "GTW-1007": "Operadora de Pagamento Indisponível",
        "GTW-1008": "Parcelamento não autorizado",
        "GTW-1009": "Cartão de Crédito Restrito",
        "GTW-1010": "Parece que seu cartão expirou",
        "GTW-1011": "Pagamento não autorizado",
        "GTW-1012": "Pagamento não autorizado",
        "GTW-1013": "Número de parcelas não autorizada",
        "GTW-1014": "Compra não autorizada",
        "GTW-1015": "Pagamento rejeitado pela revisão manual",
        "GTW-1016": "Compra não autorizada. Sessão próxima do início",
        "GTW-1017": "Pagamento não autorizado"
    ]

    public func getErrorMessage(code: Int, detailCode: String = "") -> String {
        if code == 0 {
            return errorDict["default_no_code"]!
        }

        if detailCode.contains("GTW") {
            return errorDict["default_gtw_message"]!
        }

        if detailCode.contains("CPN") {
            return errorDict["default_cpn_message"]!
        }

        guard let error = errors[code] else {
            return String(format: errorDict["default_message"]!, arguments: [code])
        }
        
        return error
    }

    public func getDetailError(detailCode: String, code: Int) -> String {
        guard let error = detailsErrorDict[detailCode] else {
            return getErrorMessage(code: code, detailCode: detailCode)
        }

        return error
    }

    public func getHttpErrorMessage(code: Int) -> String {
        if code == 0 {
            return errorDict["default_no_code"]!
        }

        guard let error = httpStatusErrors[code] else {
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
