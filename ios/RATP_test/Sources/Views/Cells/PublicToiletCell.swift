//
//  PublicToiletCell.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import SwiftUI

struct PublicToiletCell: View {
    var viewModel: PublicToiletCellViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            fullAddress

            openingHour

            prmAccess

            distanceIfPermitted

            Divider()
        }
        .background(Color.white)
    }

    var fullAddress: some View {
        imageText(imageName: "map", text: viewModel.fullAddress)
            .foregroundColor(.black)
    }

    var openingHour: some View {
        imageText(imageName: "clock", text: viewModel.openingHour)
            .foregroundColor(.black)
    }

    private func imageText(imageName: String, text: String) -> some View {
        HStack {
            Image(systemName: imageName)
                .font(.system(size: 20, weight: .bold))

            Text(text)
                .lineLimit(2)
        }
    }

    var prmAccess: some View {
        imageText(imageName: viewModel.isPrmAccess ? "checkmark" : "xmark",
                  text: viewModel.prmAccess)
        .padding(.vertical)
        .foregroundColor(viewModel.isPrmAccess ? .green : .red)
    }

    @ViewBuilder
    var distanceIfPermitted: some View {
        if let coordinate = viewModel.coordinate {
            Text("distance : \(coordinate.longitude) / \(coordinate.latitude)")
            .foregroundColor(.black)
        }
    }
}

struct PublicToiletCell_Previews: PreviewProvider {
    static var previews: some View {
        PublicToiletCell(viewModel: .mock)
    }
}
