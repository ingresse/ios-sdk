//
//  SDKErrors.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 10/31/16.
//  Copyright © 2016 Ingresse. All rights reserved.
//

import UIKit

public class SDKErrors: NSObject {
    static let shared = SDKErrors()
    
    var errors: [String:String]!
    
    public override init() {
        self.errors = SDKErrors.getErrorDict()
    }
    
    public func getErrorMessage(code:Int) -> String {
        if code == 0 {
            return errors["default_no_code"]!
        }
        
        guard let error = errors["\(code)"] else {
            return String(format: errors["default"]!, arguments: [code])
        }
        
        return error
    }
    
    public static func getErrorDict() -> [String:String] {
        var errorDict = [String:String]()
        
        errorDict["6001"] = "A venda deste evento não está ativada. Entre em contato com o organizador do evento."
        errorDict["6002"] = "Todas as sessões para esse evento estão esgotadas. Talvez alguns ingressos estarão disponíveis dependendo dos pagamentos pendentes. Entre em contato com o organizador do evento."
        errorDict["6003"] = "Não há mais ingressos disponíveis para venda. Talvez alguns ingressos estarão disponíveis dependendo dos pagamentos pendentes. Entre em contato com o organizador do evento."
        errorDict["6004"] = "Não há mais ingressos disponíveis para um dos tipos de ingressos selecionados. Entre em contato com o organizador do evento."
        errorDict["6005"] = "A transação que está tentando pagar não está mais disponível. Por favor, tente novamente."
        errorDict["6006"] = "A quantidade de ingressos disponíveis é menor que a de solicitados."
        errorDict["6007"] = "Eventos blogger não possuem venda de ingressos."
        errorDict["6008"] = "Ingresso não encontrado na sessão."
        errorDict["6009"] = "O método de pagamento e/ou parcelamento não são aceitos para este evento."
        errorDict["6010"] = "Boleto não é aceito neste evento."
        errorDict["6011"] = "Boleto não pago."
        errorDict["6012"] = "Por favor, visite o site da Ingresse (ingresse.com) para comprar ingressos para esse evento."
        errorDict["6034"] = "Ticket não está pendente. Verifique se a transferência foi cancelada."
        errorDict["6038"] = "Este ingresso já foi transferido. Atualize a sua carteira e verá para quem foi enviado o ingresso."
        
        errorDict["6039"] = "Este ingresso foi reembolsado. Atualize a sua carteira para ver somente os ingressos disponíveis."
        errorDict["6040"] = "Você já transferiu esse ingresso para um amigo."
        errorDict["6041"] = "A transferência de ingressos não está disponível para este evento."
        errorDict["6044"] = "Você excedeu o limite de ingressos disponíveis por conta. Para mais informações, verifique a descrição do evento."
        errorDict["6045"] = "Este ingresso já pertence a você e está na sua carteira."
        errorDict["default"] = "Ocorreu um problema e não conseguimos seguir em frente. Procure nosso suporte em contato@ingresse.com e informe o código ao lado. (%ld)"
        errorDict["default_no_code"] = "Ocorreu um problema e não conseguimos seguir em frente. Procure nosso suporte em contato@ingresse.com."
        
        return errorDict
    }
}
