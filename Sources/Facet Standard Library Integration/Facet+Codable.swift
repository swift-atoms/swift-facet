public import Facet
internal import Axis
internal import Axis_Standard_Library_Integration
internal import Direction
internal import Direction_Standard_Library_Integration

#if !hasFeature(Embedded)

    extension Facet: Codable {

        private enum CodingKeys: String, CodingKey {
            case axis
            case direction
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.init(
                axis: try container.decode(Axis<N>.self, forKey: .axis),
                direction: try container.decode(Direction.self, forKey: .direction)
            )
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(axis, forKey: .axis)
            try container.encode(direction, forKey: .direction)
        }
    }

#endif
