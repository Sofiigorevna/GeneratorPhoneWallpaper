//
//  Models.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 27.02.2024.
//

import Foundation

// MARK: - Request

struct GenerateImageRequest: Codable {
    let modelId: String
    let key, prompt: String
    let negativePrompt: String
    let width, height, samples: String
    let guidanceScale: Double
    let numInferenceSteps: String

    enum CodingKeys: String, CodingKey {
        case key, prompt
        case negativePrompt = "negative_prompt"
        case width, height, samples
        case numInferenceSteps = "num_inference_steps"
        case guidanceScale = "guidance_scale"
        case modelId = "model_id"
    }
}

// MARK: - Response

struct GenerateImageResponse: Codable {
    let status, tip: String
    let generationTime: Double?
    let id: Int
    let output, proxyLinks: [String]
    let nsfwContentDetected: String

    enum CodingKeys: String, CodingKey {
        case status, tip, generationTime, id, output
        case proxyLinks = "proxy_links"
        case nsfwContentDetected = "nsfw_content_detected"
    }
}
